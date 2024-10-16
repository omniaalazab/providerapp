import 'package:providerapp/model/houseman_model.dart';
import 'package:providerapp/model/services_model.dart';

class GetServiceStatus {}

class GetServiceInitial extends GetServiceStatus {}

class GetServiceLoading extends GetServiceStatus {}

class GetServiceloaded extends GetServiceStatus {
  final List<ServicesModel> serviceList;
  GetServiceloaded(this.serviceList);
}

class GetServiceFailure extends GetServiceStatus {
  final String errorMessage;

  GetServiceFailure(this.errorMessage);
}
