import 'package:providerapp/model/services_model.dart';

class ServicesStatus {}

class ServicesInitial extends ServicesStatus {}

class ServicesLoading extends ServicesStatus {}

class Servicesloaded extends ServicesStatus {
  final List<ServicesModel> servicesList;
 Servicesloaded(this.servicesList);
}

class ServicesFailure extends ServicesStatus {
  final String errorMessage;

  ServicesFailure(this.errorMessage);
}
