import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Routes/RoutesOfApp.dart';
import 'package:newmahirroadways/View/SplashPage.dart';
import 'package:newmahirroadways/firebase_options.dart';
import 'package:newmahirroadways/provider/AddDataFunction.dart';
import 'package:newmahirroadways/provider/ImagePicker.dart';
import 'package:newmahirroadways/provider/diesleProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddDataProvider()),
        ChangeNotifierProvider(create: (context) => DieselProvider()),
        ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(350, 680),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesOfApp.genRoutes,
            title: 'Name Of App',
            theme: ThemeData(
              fontFamily: 'main',
              useMaterial3: true,
            ),
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
