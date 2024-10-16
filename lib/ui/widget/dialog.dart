import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/controller/theme_cubit.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';

class CreateDialogToaster {
  static Future showErrorDialogDefult(
      String msgTitle, String masgContent, var context) {
    return showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  msgTitle,
                  style: TextStyleHelper.textStylefontSize22
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              content: Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        masgContent,
                        style: TextStyleHelper.textStylefontSize13,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CircularProgressIndicator(
                        color: ColorHelper.purple,
                      ),
                    ],
                  ),
                ),
              ),
            )
        // titlePadding:
        //     const EdgeInsets.only(top: 10),

        );
  }

  static Future DialogAppTheme(var context) {
    return showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Container(
            // color: ColorHelper.purple,
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).CheckAppTheme,
                    style: TextStyleHelper.textStylefontSize16
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ])),
        content: Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme(false);
                },
                child: Text(S.of(context).LightMode,
                    style: TextStyleHelper.textStylefontSize14),
              ),
              TextButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme(true);
                },
                child: Text(S.of(context).DarkMode,
                    style: TextStyleHelper.textStylefontSize14),
              )
            ],
          ),
        ),
      ),
    );
    // titlePadding:
    //     const EdgeInsets.only(top: 10),
  }

  static void showErrorToast(String msgText) {
    Fluttertoast.showToast(
        msg: msgText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSucessToast(String msgText) {
    Fluttertoast.showToast(
        msg: msgText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: const Color.fromARGB(255, 50, 161, 23),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
