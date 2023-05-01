import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/amer_screens/student/daily_bus.dart';
import 'package:uber/destination_screen.dart';
import 'package:uber/home_page.dart';
import 'package:uber/hussam_screens/payments_method_2.dart';
import 'package:uber/settings_screen.dart';
import 'package:uber/welcome_screen.dart';
import 'package:uber/ziad_screens/login/phone_login.dart';
import 'package:uber/ziad_screens/login/verify_OTP_login.dart';
import 'package:uber/ziad_screens/review.dart';
import 'package:uber/ziad_screens/signup/phone.dart';
import 'package:uber/ziad_screens/signup/register_screen.dart';
import 'package:uber/ziad_screens/signup/verify_OTP.dart';

import 'amer_screens/student/choose_bus.dart';
import 'functions/Map.dart';
import 'hussam_screens/payments_methods_1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: WelcomePageWidget(),
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(builder: (context) => WelcomePageWidget());
        case '/home':
          return MaterialPageRoute(builder: (context) => NavBarWidget());
        case '/destination':
          return MaterialPageRoute(
              builder: (context) => DestinationPageWidget());
        case '/welcome':
          return MaterialPageRoute(builder: (context) => WelcomePageWidget());
        case '/phoneLogin':
          return MaterialPageRoute(builder: (context) => PhoneOTPLoginScreen());
        case '/otpLogin':
          return MaterialPageRoute(builder: (context) => OTPLoginScreen());
        case '/phoneSignup':
          return MaterialPageRoute(
              builder: (context) => PhoneOTPScreen(
                    firstName: '',
                    lastName: '',
                    password: '',
                    email: '',
                  ));
        case '/otpSignup':
          return MaterialPageRoute(
              builder: (context) => OTPScreen(
                    firstName: '',
                    lastName: '',
                    password: '',
                    email: '',
                    phoneNumber: '',
                  ));
        case '/register':
          return MaterialPageRoute(builder: (context) => SignUpScreen());
        case '/review':
          return MaterialPageRoute(builder: (context) => ReviewScreen());
        case '/settings':
          return MaterialPageRoute(builder: (context) => SettingsPageWidget());
        case '/payments':
          return MaterialPageRoute(
              builder: (context) => PaymentMethods1Widget());
        case '/credit_cards':
          return MaterialPageRoute(
              builder: (context) => PaymentMethods2Widget());
        case '/avail_buses':
          return MaterialPageRoute(
              builder: (context) => ChooseBusScreen(
                    uniName: '',
                  ));
        case '/daily_buses':
          return MaterialPageRoute(builder: (context) => DailyBusScreen());
        case '/map':
          return MaterialPageRoute(builder: (context) => MapScreen());
        default:
          return MaterialPageRoute(builder: (context) => NavBarWidget());
      }
    },
  ));
}
