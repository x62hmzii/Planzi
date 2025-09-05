import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:planizi/pages/home_page.dart';


void main() async{

  await Hive.initFlutter();
  var box= await Hive.openBox('myBox');

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
      theme:ThemeData(primarySwatch: Colors.yellow,
      appBarTheme: const AppBarTheme(color: Colors.yellow)),
    );
  }
}
