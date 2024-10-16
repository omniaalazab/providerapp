import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:providerapp/controller/check_empty_field_function.dart';

import 'package:providerapp/controller/get_service/get_service_cubit.dart';
import 'package:providerapp/ui/widget/shared_widget/text_field.dart';

class DialogEditAddressService {
  static void showRatingDialog(BuildContext context,
      TextEditingController addressController, String oldaddress) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit address'),
          content: CustomTextField(
            textLabel: "",
            textController: addressController,
            textFieldSuffix: const SizedBox(
              height: 1,
            ),
            validatorFunction: (value) {
              CheckEmptyValidationTextField.checkIsEmpty(value);
              return null;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<GetServiceCubit>()
                    .editAddressService(oldaddress, addressController.text);

                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
