import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/controller/add_service/add_service_cubit.dart';
import 'package:providerapp/controller/add_service/add_service_state.dart';
import 'package:providerapp/controller/check_empty_field_function.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/view/service_list.dart';
import 'package:providerapp/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:providerapp/ui/widget/shared_widget/text_field.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController housemanNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController rateController = TextEditingController();

  TextEditingController discountController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController minutsController = TextEditingController();
  @override
  void initState() {
    context.read<AddServiceCubit>().fetchServiceImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AddService,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 15),
          child: Column(
            children: [
              Center(
                child: DottedBorder(
                    color: ColorHelper.purple,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    dashPattern: const [8, 4],
                    strokeWidth: 2,
                    child: Container(
                      alignment: Alignment.center,
                      // decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 200,
                      width: MediaQuery.of(context).size.width * .7,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              context
                                  .read<AddServiceCubit>()
                                  .pickImageFromGallery(context);
                            },
                            child: BlocBuilder<AddServiceCubit, ServicesStatus>(
                              builder: (context, state) {
                                if (state is ServicesSuccess) {
                                  return Image(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    image: state
                                        .imageProvider, // Use the image from the success state
                                  );
                                } else if (state is ServicesLoading) {
                                  return const SizedBox(
                                    height: 100,
                                    width: 300,
                                    child: Center(
                                      child:
                                          CircularProgressIndicator(), // Show a loading indicator while uploading
                                    ),
                                  );
                                } else {
                                  return const Image(
                                    height: 100,
                                    width: 300,
                                    image: NetworkImage(
                                        "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcR6dd57Z2YLZ6ykXZRcjPAHpYKVWBf3NHnjbgzaaXJJUXOyBCmq"),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Text(S.of(context).ChooseImageSupportJPGPNG),
              Container(
                child: Column(
                  children: [
                    CustomTextField(
                      textLabel: S.of(context).ServiceName,
                      textController: serviceNameController,
                      textFieldSuffix: const SizedBox(
                        height: 1,
                      ),
                      validatorFunction: (value) {
                        CheckEmptyValidationTextField.checkIsEmpty(value);
                        return null;
                      },
                    ),
                    CustomTextField(
                      textLabel: S.of(context).HousemanName,
                      textController: housemanNameController,
                      textFieldSuffix: const SizedBox(
                        height: 1,
                      ),
                      validatorFunction: (value) {
                        CheckEmptyValidationTextField.checkIsEmpty(value);
                        return null;
                      },
                    ),
                    CustomTextField(
                      textLabel: S.of(context).AddAddress,
                      textController: addressController,
                      textFieldSuffix: const SizedBox(
                        height: 1,
                      ),
                      validatorFunction: (value) {
                        CheckEmptyValidationTextField.checkIsEmpty(value);
                        return null;
                      },
                    ),
                    CustomTextField(
                      textLabel: S.of(context).Rate,
                      textController: rateController,
                      textFieldSuffix: const SizedBox(
                        height: 1,
                      ),
                      validatorFunction: (value) {
                        CheckEmptyValidationTextField.checkIsEmpty(value);
                        return null;
                      },
                    ),
                    Row(children: [
                      Expanded(
                        child: CustomTextField(
                          textLabel: S.of(context).Price,
                          textController: priceController,
                          textFieldSuffix: const SizedBox(
                            height: 1,
                          ),
                          validatorFunction: (value) {
                            CheckEmptyValidationTextField.checkIsEmpty(value);
                            return null;
                          },
                        ),
                      ),
                      // Expanded(
                      //   child: CustomTextField(
                      //     textLabel: "discount",
                      //     textController: discountController,
                      //     textFieldSuffix: const SizedBox(
                      //       height: 1,
                      //     ),
                      //     validatorFunction: (value) {
                      //       CheckEmptyValidationTextField.checkIsEmpty(value);
                      //       return null;
                      //     },
                      //   ),
                      // )
                    ]),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            textLabel: S.of(context).Duration,
                            textController: durationController,
                            textFieldSuffix: const SizedBox(
                              height: 1,
                            ),
                            validatorFunction: (value) {
                              CheckEmptyValidationTextField.checkIsEmpty(value);
                              return null;
                            },
                          ),
                        ),
                        // Expanded(
                        //   child: CustomTextField(
                        //     textLabel: "Duratioin mint",
                        //     textController: minutsController,
                        //     textFieldSuffix: const SizedBox(
                        //       height: 1,
                        //     ),
                        //     validatorFunction: (value) {
                        //       CheckEmptyValidationTextField.checkIsEmpty(value);
                        //       return null;
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                    CustomTextField(
                      textLabel: S.of(context).Descriptionofservice,
                      textController: descriptionController,
                      textFieldSuffix: const SizedBox(
                        height: 1,
                      ),
                      validatorFunction: (value) {
                        CheckEmptyValidationTextField.checkIsEmpty(value);
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                        buttonText: S.of(context).Save,
                        onPressedFunction: () {
                          context.read<AddServiceCubit>().addNewService(
                                double.parse(priceController.text),
                                descriptionController.text,
                                durationController.text,
                                serviceNameController.text,
                                addressController.text,
                                housemanNameController.text,
                                double.parse(rateController.text),
                              );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AllServiceList()));
                        },
                        backColor: ColorHelper.purple,
                        fontColor: Colors.white)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
