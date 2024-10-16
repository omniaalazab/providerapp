import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/controller/get_service/get_service_state.dart';
import 'package:providerapp/model/services_model.dart';

class GetServiceCubit extends Cubit<GetServiceStatus> {
  GetServiceCubit() : super(GetServiceInitial());
  Future<void> getServices() async {
    emit(GetServiceLoading());
    try {
      final querySnapShot =
          await FirebaseFirestore.instance.collection("services").get();

      List<ServicesModel> service = querySnapShot.docs
          .map((doc) => ServicesModel.fromSnapshot(doc))
          .toList();
      emit(GetServiceloaded(service));
    } catch (e) {
      emit(GetServiceFailure(e.toString()));
    }
  }

  Future<void> editAddressService(String oldAddress, newAddress) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('services')
          .where('address', isEqualTo: oldAddress)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('services')
            .doc(docId)
            .update({'address': newAddress});
        getServices();

        log('Address updated to $newAddress');
      } else {
        print('No document found with the address: $oldAddress');
      }
    } catch (error) {
      print('Failed to update address: $error');
    }
  }
}
