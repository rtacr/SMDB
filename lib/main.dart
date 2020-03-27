
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smdp/pages/initial_page.dart';
import 'package:smdp/pages/page_one.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(31, 54, 92, .1),
    100: Color.fromRGBO(31, 54, 92, .2),
    200: Color.fromRGBO(31, 54, 92, .3),
    300: Color.fromRGBO(31, 54, 92, .4),
    400: Color.fromRGBO(31, 54, 92, .5),
    500: Color.fromRGBO(31, 54, 92, .6),
    600: Color.fromRGBO(31, 54, 92, .7),
    700: Color.fromRGBO(31, 54, 92, .8),
    800: Color.fromRGBO(31, 54, 92, .9),
    900: Color.fromRGBO(31, 54, 92, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: Consumer<Counter>(builder: (context, counter, _) {
        return Material(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Automation',
            theme: ThemeData(
                primarySwatch: MaterialColor(0xFF1f365c, color),
                accentColor: Color.fromRGBO(31, 54, 92, 1),
                textTheme: TextTheme(body1: TextStyle(color: Colors.black))),
            home: InitPage(),
          ),
        );
      }),
    );
  }
}
