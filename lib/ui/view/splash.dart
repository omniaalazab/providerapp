import 'package:flutter/material.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/view/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  double opacity = 0;
  startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1;
      });
    });
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 5),
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    width: 150,
                    height: 300,
                    image: AssetImage("assets/images/Houseman Logo.png")),

                Text(S.of(context).Provider,
                    //    S.of(context).Houseman,
                    style: TextStyleHelper.textStylefontSize24),
                //
                // Container(
                //   alignment: Alignment.center,
                //   width: double.infinity,
                //   height:700,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(30),
                //     color: ColorHelper.darkpurple,
                //   ),
                //   child:

                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
