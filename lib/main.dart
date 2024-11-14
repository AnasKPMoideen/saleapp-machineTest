import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saleapp/screens/Home/home_screen.dart';
import 'package:saleapp/screens/Splash/splash_screen.dart';
import 'package:saleapp/screens/auth/login_screen.dart';
import 'Contollers/providers/auth_provider.dart';
import 'Contollers/providers/store_provider.dart';
import 'firebase_options.dart';
import 'package:google_api_availability/google_api_availability.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoogleApiAvailability.instance.checkGooglePlayServicesAvailability().then((availability) {
    if (availability != GooglePlayServicesAvailability.success) {
      log("Google Play services are not available.");
    }
  });
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
      ],
      child: MaterialApp(
        title: 'SaleApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/home' : (context) => HomeScreen(),
          '/login' : (context) => LoginScreen(),
        },
        // home: LoginScreen(),
      ),
    );
  }
}