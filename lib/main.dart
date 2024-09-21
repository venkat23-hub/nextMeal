import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:nextmeal/screens/getstarted_page.dart';
import 'package:nextmeal/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NextMeal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStartedPage(),
    );
  }
}
// NOTE:
//add values.xml file while working with phone auth.
//setings.gradle is for import of plugin id,

//TODO:
// work on dark mode
