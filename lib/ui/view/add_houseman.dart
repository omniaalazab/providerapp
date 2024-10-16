import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/controller/check_empty_field_function.dart';
import 'package:providerapp/controller/houseman/houseman_cubit.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/model/houseman_model.dart';
import 'package:providerapp/ui/view/houseman_list.dart';
import 'package:providerapp/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:providerapp/ui/widget/shared_widget/text_field.dart';

class AddHouseman extends StatelessWidget {
  AddHouseman({super.key});
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).Houseman,
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddHouseman()));
                },
                icon: const Icon(Icons.add, color: Colors.white))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              children: [
                CustomTextField(
                  textLabel: S.of(context).FullName,
                  textController: fullNameController,
                  textFieldSuffix: Image.asset("assets/images/Profile1.png"),
                  validatorFunction: (value) {
                    CheckEmptyValidationTextField.checkIsEmpty(value);
                    return null;
                  },
                ),
                CustomTextField(
                  textLabel: S.of(context).EmailAddress,
                  keyboardType: TextInputType.emailAddress,
                  textController: mailController,
                  textFieldSuffix: Image.asset("assets/images/Message.png"),
                  validatorFunction: (value) {
                    CheckEmptyValidationTextField.checkIsEmpty(value);
                    return null;
                  },
                ),
                CustomTextField(
                  textLabel: S.of(context).AddAddress,
                  textController: addressController,
                  textFieldSuffix: Image.asset("assets/images/Location.png"),
                  validatorFunction: (value) {
                    CheckEmptyValidationTextField.checkIsEmpty(value);
                    return null;
                  },
                ),
                CustomTextField(
                  textLabel: S.of(context).PhoneNumber,
                  keyboardType: TextInputType.number,
                  textController: phoneNumberController,
                  textFieldSuffix: Image.asset("assets/images/Calling.png"),
                  validatorFunction: (value) {
                    CheckEmptyValidationTextField.checkIsEmpty(value);
                    return null;
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomElevatedButton(
                  backColor: ColorHelper.purple,
                  fontColor: Colors.white,
                  buttonText: S.of(context).Save,
                  onPressedFunction: () {
                    context.read<HousemanCubit>().addHouseman(HousemanModel(
                        imagePath:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkm4gFfMwEOyAvHpJCCnFxKn7950N-1Y5XfL8ZcEtJBegW686eTtxClWkWDuE2M92w3Nk&usqp=CAU",
                        name: fullNameController.text,
                        rate: 3,
                        address: addressController.text,
                        housemanMail: mailController.text,
                        housemanPhone: phoneNumberController.text));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HousemanList()));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
