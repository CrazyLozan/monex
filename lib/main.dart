


import 'package:flutter/material.dart';

import 'package:monex/src/pages/(1)home_page.dart';
import 'package:monex/src/pages/(2)scaning_page.dart';
import 'package:monex/src/pages/(3)addding_page.dart';
import 'package:monex/src/pages/(4)display_page.dart';
import 'package:monex/src/pages/(5)sumall_page.dart';
import 'package:monex/src/pages/(6)convertall_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneX',
      initialRoute: 'home' ,
      routes: {
        'home' : (_) => HomePage(),
        'scan' : (BuildContext context) => ScanPage(),
        'add' : (BuildContext context) => AddPage(),
        'display' : (BuildContext context) => DisplayPage(),
        'sum' : (BuildContext context) => SumPage(),
        'convert' : (BuildContext context) => ConvertAllPage(),
      },
      theme: ThemeData(primaryColor: Colors.pink),
    );
  }
}

