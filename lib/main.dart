import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackdu/pages/auth.dart';
import 'package:hackdu/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseAuth.instance.userChanges().listen((User? user) {
  //   if (user == null) {
  //     print("Signed out");
  //   }else
  //     {
  //       print("Signed in");
  //     }
  // });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
