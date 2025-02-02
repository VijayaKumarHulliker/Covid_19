
import 'package:covidapp/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        brightness: Brightness.dark,
        primarySwatch: Colors.blue
      ),
      home: const SplashScreen(),
    );
  }
}