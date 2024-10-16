import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:providerapp/controller/get_service/get_service_cubit.dart';
import 'package:providerapp/controller/get_service/get_service_state.dart';

import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/widget/address_edit_dialog.dart';

class ServiceAddress extends StatefulWidget {
  const ServiceAddress({super.key});

  @override
  State<ServiceAddress> createState() => _ServiceAddressState();
}

class _ServiceAddressState extends State<ServiceAddress> {
  @override
  void initState() {
    context.read<GetServiceCubit>().getServices();
    super.initState();
  }

  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).ServiceAddress,
              style: TextStyleHelper.textStylefontSize19
                  .copyWith(color: Colors.white)),
          backgroundColor: ColorHelper.purple,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<GetServiceCubit, GetServiceStatus>(
            builder: (context, state) {
          if (state is GetServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetServiceloaded) {
            final service = state.serviceList;
            return ListView.builder(
                itemCount: service.length,
                itemBuilder: (context, index) {
                  log("${service.length}");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(service[index].address,
                                    style: TextStyleHelper.textStylefontSize16),
                                TextButton(
                                  child: Text(S.of(context).Edit,
                                      style:
                                          TextStyleHelper.textStylefontSize14),
                                  onPressed: () {
                                    DialogEditAddressService.showRatingDialog(
                                      context,
                                      addressController,
                                      service[index].address,
                                    );
                                  },
                                ),
                              ],
                            ))),
                  );
                });
          } else if (state is GetServiceFailure) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        }));
  }
}
