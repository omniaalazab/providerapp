import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:providerapp/controller/check_empty_field_function.dart';
import 'package:providerapp/controller/profile/profile_cubit.dart';
import 'package:providerapp/controller/profile/profile_state.dart';
import 'package:providerapp/controller/user/user_cubit.dart';
import 'package:providerapp/controller/user/user_state.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/view/profile.dart';
import 'package:providerapp/ui/widget/dialog.dart';
import 'package:providerapp/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:providerapp/ui/widget/shared_widget/text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  bool isObsecurePass = true;
  @override
  void initState() {
    context.read<ProfileCubit>().fetchProfileImage(context);
    if (user != null) {
      mailController.text = user!.email ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          S.of(context).EditProfile,
          style: TextStyleHelper.textStylefontSize20
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: Column(
            children: [
              // Profile Image Section
              Stack(
                children: [
                  BlocConsumer<ProfileCubit, ProfileStatus>(
                      listener: (context, state) {
                    if (state is ProfileFailure) {
                      CreateDialogToaster.showErrorToast(
                          S.of(context).OopsThereisanerror);
                    }
                  }, builder: (context, state) {
                    if (state is ProfileSuccess) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<ProfileCubit>()
                              .changeProfileImage(context);
                        },
                        child: CircleAvatar(
                          backgroundImage: state.imageProvider,
                          radius: 50,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        context
                            .read<ProfileCubit>()
                            .changeProfileImage(context);
                      },
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/Profile.png"),
                        radius: 50,
                      ),
                    );
                  }),
                  Positioned(
                    left: 60,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<ProfileCubit>()
                            .changeProfileImage(context);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorHelper.purple,
                        child: const Icon(Icons.camera_enhance_outlined),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Form Section
              Form(
                key: formState,
                child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                  if (state.user.isNotEmpty) {
                    return Column(
                      children: [
                        CustomTextField(
                          textController: fullNameController,
                          textLabel: S.of(context).FullName,
                          textFieldSuffix: Icon(
                            Icons.person_outline_rounded,
                            color: ColorHelper.darkgrey,
                          ),
                          validatorFunction: (value) {
                            CheckEmptyValidationTextField.checkIsEmpty(value);
                            return null;
                          },
                        ),
                        CustomTextField(
                          textController: userNameController,
                          textLabel: S.of(context).UserName,
                          textFieldSuffix: Icon(
                            Icons.person_outline_rounded,
                            color: ColorHelper.darkgrey,
                          ),
                          validatorFunction: (value) {
                            CheckEmptyValidationTextField.checkIsEmpty(value);
                            return null;
                          },
                        ),
                        CustomTextField(
                          textController: mailController,
                          textLabel: S.of(context).EmailAddress,
                          textFieldSuffix: Icon(
                            Icons.mail_outlined,
                            color: ColorHelper.darkgrey,
                          ),
                          validatorFunction: (value) {
                            CheckEmptyValidationTextField.checkIsEmpty(value);
                            return null;
                          },
                        ),
                        CustomTextField(
                          textController: phoneController,
                          textLabel: S.of(context).PhoneNumber,
                          textFieldSuffix: Icon(
                            Icons.phone_in_talk_rounded,
                            color: ColorHelper.darkgrey,
                          ),
                          validatorFunction: (value) {
                            if (value!.length != 11) {
                              return S.of(context).Phonenumberisnotcorrect;
                            }
                            CheckEmptyValidationTextField.checkIsEmpty(value);
                            return null;
                          },
                        ),
                        CustomTextField(
                          textController: passwordController,
                          textLabel: S.of(context).Password,
                          isObsecure: isObsecurePass,
                          textFieldSuffix: IconButton(
                            icon: isObsecurePass
                                ? Icon(Icons.visibility_off,
                                    color: ColorHelper.darkgrey)
                                : Icon(Icons.visibility,
                                    color: ColorHelper.darkgrey),
                            onPressed: () {
                              setState(() {
                                isObsecurePass = !isObsecurePass;
                              });
                            },
                          ),
                          validatorFunction: (value) {
                            if (value!.length < 8) {
                              return S.of(context).Passwordisweak;
                            }
                            CheckEmptyValidationTextField.checkIsEmpty(value);
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Confirm Button
                        CustomElevatedButton(
                          textSize: 18,
                          buttonText: S.of(context).confirm,
                          onPressedFunction: () async {
                            if (formState.currentState!.validate()) {
                              try {
                                await context.read<UserCubit>().updateUser(
                                      userMail: mailController.text,
                                      userFullName: fullNameController.text,
                                      userName: userNameController.text,
                                      userPassword: passwordController.text,
                                      phoneNumber: phoneController.text,
                                    );
                                Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ProfileScreen()),
                                );
                              } catch (e) {
                                if (mounted) {
                                  CreateDialogToaster.showErrorToast(
                                    S.of(context).Failedtoupdateprofile,
                                  );
                                }
                              }
                            }
                          },
                          backColor: ColorHelper.purple,
                          fontColor: Colors.black,
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
