import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:providerapp/controller/add_service/add_service_state.dart';
import 'package:providerapp/model/houseman_model.dart';
import 'package:providerapp/model/services_model.dart';
import 'package:providerapp/ui/widget/dialog.dart';

class AddServiceCubit extends Cubit<ServicesStatus> {
  late String downloadUrl;
  String? userMail = FirebaseAuth.instance.currentUser!.email;
  AddServiceCubit() : super(ServicesInitial());
  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery(var context) async {
    try {
      CreateDialogToaster.showErrorDialogDefult(
          "Loading", "Image  Loading", context);
      emit(ServicesLoading());
      XFile? pickImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickImage != null) {
        File imageFile = File(pickImage.path);
        //  imagePath = pickImage.path;
        // String? userMail = FirebaseAuth.instance.currentUser!.email;
        Reference storge = FirebaseStorage.instance
            .ref()
            .child('serviceImage')
            .child("$userMail.jpg");

        UploadTask uploadtask = storge.putFile(imageFile);
        TaskSnapshot snapShot = await uploadtask;
        downloadUrl = await snapShot.ref.getDownloadURL();

        emit(ServicesSuccess(NetworkImage(downloadUrl)));
      }
    } catch (e) {
      log(e.toString());
    }
    Navigator.pop(context);
  }

  Future<void> fetchServiceImage() async {
    try {
      emit(ServicesLoading());
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('serviceImage')
          .child("$userMail.jpg");

      String downloadUrl = await storageRef.getDownloadURL();
      emit(ServicesSuccess(NetworkImage(downloadUrl)));
    } catch (e) {
      log(e.toString());
      emit(ServicesFailure("Failed to load image"));
    }
  }

  Future<void> addNewService(
      double price,
      String descriptionEn,
      String duration,
      String nameServiceEn,
      String address,
      String housemanName,
      double rate) async {
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('serviceImage')
        .child("$userMail.jpg");

    String downloadUrl = await storageRef.getDownloadURL();

    try {
      User? user1 = FirebaseAuth.instance.currentUser;

      final service = ServicesModel(
        descriptionAr: descriptionEn,
        descriptionEn: descriptionEn,
        duration: duration,
        address: address,
        houseman: HousemanModel(
          imagePath: "https://www.galtaji.org/assets/images/location/01.jpg",
          name: housemanName,
          rate: rate,
          address: "",
          housemanMail: "",
          housemanPhone: "",
        ),
        imagePathService: downloadUrl ?? "",
        nameServiceAr: nameServiceEn,
        nameServiceEn: nameServiceEn,
        price: price,
      );

      await FirebaseFirestore.instance
          .collection('services')
          .add(service.toMap());
      log("Service successfully saved");
    } catch (e) {
      log("Error saving service: ${e.toString()}");
      emit(ServicesFailure("Failed to save service"));
    }
  }
}
