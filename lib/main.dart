import 'package:flutter/material.dart';
import 'package:poc_vuca/pages/CartPage.dart';
import 'pages/HomePage.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder> {
        '/home': (context) => new HomePage(),
        '/cart' : (context) => new CartPage()
      },
      home: getStartPage(),
    );
  }

  Widget getStartPage() {
    return HomePage();
  }
}
