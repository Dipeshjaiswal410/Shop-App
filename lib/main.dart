import 'package:flutter/material.dart';
import 'package:margintop_solutions/views/loginView/loginProvider.dart';
import 'package:margintop_solutions/views/splashView/splashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context)=>LoginProvider(),  //Login Provider 
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
