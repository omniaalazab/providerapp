import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:providerapp/controller/add_service/add_service_cubit.dart';
import 'package:providerapp/controller/booking/booking_cubit.dart';
import 'package:providerapp/controller/houseman/houseman_cubit.dart';
import 'package:providerapp/controller/localization/localization.dart';
import 'package:providerapp/controller/login/login_cubit.dart';
import 'package:providerapp/controller/notification/notification_cubit.dart';
import 'package:providerapp/controller/profile/profile_cubit.dart';
import 'package:providerapp/controller/rating.dart';
import 'package:providerapp/controller/regestration/registration_cubit.dart';
import 'package:providerapp/controller/remember/remember_cubit.dart';
import 'package:providerapp/controller/reset/reset_cubit.dart';
import 'package:providerapp/controller/review/review_cubit.dart';
import 'package:providerapp/controller/search/search_cubit.dart';
import 'package:providerapp/controller/get_service/get_service_cubit.dart';
import 'package:providerapp/controller/services/services_cubit.dart';
import 'package:providerapp/controller/signout/signout_cubit.dart';
import 'package:providerapp/controller/theme_cubit.dart';
import 'package:providerapp/controller/user/user_cubit.dart';
import 'package:providerapp/firebase_options.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/ui/view/registration.dart';
import 'package:providerapp/ui/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  getToken();
  runApp(const ProviderApp());
}

getToken() async {
  try {
    String? myToken = await FirebaseMessaging.instance.getToken();
    // String token = await Candidate().getToken();
    log("==================================");
    log('$myToken');
  } catch (e) {
    log(e.toString());
  }
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => RegistrationCubit(),
          ),
          BlocProvider(
            create: (context) => RememberCubit(),
          ),
          BlocProvider(create: (_) => ResetCubit()),
          BlocProvider(create: (_) => UserCubit()),
          BlocProvider(create: (_) => ReviewCubit()),
          BlocProvider(create: (_) => BookingCubit()),
          BlocProvider(create: (_) => NotificationCubit()),
          BlocProvider(create: (_) => ProfileCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
          // BlocProvider(create: (_) => ChatCubit()),
          BlocProvider(create: (_) => SignOutCubit()),

          BlocProvider(create: (_) => LocalizationCubit()),
          BlocProvider(create: (_) => HousemanCubit()),
          BlocProvider(create: (_) => ServicesCubit()),
          BlocProvider(create: (_) => SearchCubit()),
          BlocProvider(create: (_) => RatingCubit()),
          BlocProvider(create: (_) => AddServiceCubit()),
          BlocProvider(create: (_) => GetServiceCubit()),

          // BlocProvider(create: (_) => WrittenSearchCubit()),
          // BlocProvider(create: (_) => ChatMessageCubit()),
        ],
        child:
            BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
          return BlocBuilder<LocalizationCubit, LocalizationState>(
              builder: (context, state) {
            return MaterialApp(
              locale: state.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepPurple,
                scaffoldBackgroundColor: Colors.black,
                brightness: Brightness.dark,
              ),
              home: const AuthStateHandler(),
            );
          });
        }));
  }
}

class AuthStateHandler extends StatelessWidget {
  const AuthStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return const Splash();
        } else {
          return const Registration();
        }
      },
    );
  }
}
