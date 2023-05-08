import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/constants/colors.dart';
import 'package:test_app/constants/data.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/screens/home/home_screen.dart';
import 'package:test_app/widgets/button.dart';
import 'package:test_app/widgets/opacity_feedback.dart';
import 'package:test_app/widgets/search_input.dart';
import 'package:test_app/widgets/stepper.dart';
import 'package:test_app/widgets/typography.dart';
import 'package:unicons/unicons.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        
      ),
      home: HomeScreen(),
    );
  }
}

