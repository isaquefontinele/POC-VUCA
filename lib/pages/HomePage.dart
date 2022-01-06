import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/webservices/vuca/getMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Menu? mainMenu;

  @override
  void initState() {
    super.initState();
    loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Text(
          mainMenu!.categories![0].desc!,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 30),
        )
      ),
    );
  }

  void loadMenu() {
    GetMenuService().getFullMenu().then((menu) => {
      setState(() {
        mainMenu = menu;
      })
    });
  }
}
