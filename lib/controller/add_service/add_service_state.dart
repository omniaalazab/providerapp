import 'package:flutter/material.dart';

class ServicesStatus {}

class ServicesInitial extends ServicesStatus {}

class ServicesLoading extends ServicesStatus {}

class ServicesSuccess extends ServicesStatus {
  final ImageProvider<Object> imageProvider;

  ServicesSuccess(this.imageProvider);
}

class ServicesFailure extends ServicesStatus {
  final String error;

  ServicesFailure(this.error);
}
