import 'package:providerapp/model/services_model.dart';

class SearchStatus {}

class SearchInitial extends SearchStatus {}

class SearchLoading extends SearchStatus {}

class SearchLoaded extends SearchStatus {
  final List<ServicesModel> serviceModel;
  SearchLoaded(this.serviceModel);
}

class SearchSuccess extends SearchStatus {
  final List<ServicesModel> serviceModel;
  SearchSuccess(this.serviceModel);
}

class SearchFailure extends SearchStatus {
  final String errorMessage;

  SearchFailure(this.errorMessage);
}
