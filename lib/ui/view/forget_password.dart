import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:providerapp/controller/check_empty_field_function.dart';
import 'package:providerapp/controller/reset/reset_cubit.dart';
import 'package:providerapp/controller/reset/reset_state.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/view/sendmail_reset.dart';
import 'package:providerapp/ui/widget/dialog.dart';
import 'package:providerapp/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:providerapp/ui/widget/shared_widget/text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _FordgetPasswordState();
}

class _FordgetPasswordState extends State<ForgetPassword> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController mailController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool isObsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetCubit(),
      child: Scaffold(
          appBar: AppBar(
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
            title: Text(S.of(context).Forgetpassword,
                style: TextStyleHelper.textStylefontSize20.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          //   backgroundColor: ColorHelper.darkpurple,
          body:
              BlocConsumer<ResetCubit, ResetStatus>(listener: (context, state) {
            if (state is ResetSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SendMailToReset()),
              );
            } else if (state is ResetFailure) {
              CreateDialogToaster.showErrorToast(state.errorMessage);
            } else if (state is ResetLoading) {
              CreateDialogToaster.showErrorDialogDefult(
                  S.of(context).loading, S.of(context).waitPlease, context);
            }
          }, builder: (context, state) {
            return Scaffold(
                body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formState,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                              textLabel: S.of(context).EmailAddress,
                              textFieldSuffix: Icon(
                                Icons.mail_outlined,
                                color: ColorHelper.darkgrey,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textController: mailController,
                              validatorFunction: (value) {
                                CheckEmptyValidationTextField.checkIsEmpty(
                                    value);
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomElevatedButton(
                            backColor: ColorHelper.purple,
                            //  sideColor: ColorHelper.black,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            buttonText: S.of(context).Continue,
                            onPressedFunction: () async {
                              if (formState.currentState!.validate()) {
                                // context.read<LoginCubit>().login(Users(
                                //     email: mailController.text,
                                //     password: passwordController.text));
                                context
                                    .read<ResetCubit>()
                                    .resetPassword(mailController.text);
                                //  email: mailController.text,
                                //  password: passwordController.text);
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
          })),
    );
  }
}
