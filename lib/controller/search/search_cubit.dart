import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/controller/search/search_state.dart';
import 'package:providerapp/model/services_model.dart';

class SearchCubit extends Cubit<SearchStatus> {
  SearchCubit() : super(SearchInitial());
  List<ServicesModel> servicesProduct = [];
  List<ServicesModel> resultServicesList = [];

  Future<void> getFirestoreDocuments() async {
    emit(SearchLoading());
    try {
      final data = await FirebaseFirestore.instance
          .collection('services')
          .orderBy('imagePathService')
          .get();
      servicesProduct =
          data.docs.map((doc) => ServicesModel.fromSnapshot(doc)).toList();
      log("----------------------------------------------*****----------------");
      emit(SearchLoaded(servicesProduct));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }

  void searchResultList(String query, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

    print('Locale: $locale');
    print('Query: $query');

    if (query.isEmpty) {
      resultServicesList = List.from(servicesProduct);
    } else {
      resultServicesList = servicesProduct.where((service) {
        if (locale == 'en') {
          return service.nameServiceEn
              .toLowerCase()
              .contains(query.toLowerCase());
        } else if (locale == 'ar') {
          return service.nameServiceAr
              .toLowerCase()
              .contains(query.toLowerCase());
        }
        return false;
      }).toList();
    }

    print('Result list length: ${resultServicesList.length}');

    if (resultServicesList.isNotEmpty) {
      emit(SearchSuccess(resultServicesList));
    } else {
      emit(SearchFailure('No Services found'));
    }
  }
}
