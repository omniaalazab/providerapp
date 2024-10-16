import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:providerapp/controller/services/services_status.dart';

import 'package:providerapp/model/services_model.dart';

class ServicesCubit extends Cubit<ServicesStatus> {
  ServicesCubit() : super(ServicesInitial());
  Future<void> getAllservices() async {
    emit(ServicesLoading());
    try {
      final querySnapShot =
          await FirebaseFirestore.instance.collection("services").get();

      List<ServicesModel> services = querySnapShot.docs
          .map((doc) => ServicesModel.fromSnapshot(doc))
          .toList();
      emit(Servicesloaded(services));
    } catch (e) {
      emit(ServicesFailure(e.toString()));
    }
  }

  Future<void> addServices(ServicesModel services) async {
    try {
      await FirebaseFirestore.instance
          .collection("services")
          .add(services.toMap());
      log("services added successfully.");
      getAllservices(); // Fetch updated booking list after adding
    } catch (e) {
      log("Error adding services: $e");
      emit(ServicesFailure(e.toString()));
    }
  }
}
