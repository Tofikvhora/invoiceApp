import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Routes/RoutesOfApp.dart';
import 'package:newmahirroadways/View/HomePage.dart';
import 'package:newmahirroadways/provider/AddDataFunction.dart';
import 'package:newmahirroadways/provider/diesleProvider.dart';
import 'package:provider/provider.dart';

void main() {
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
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
