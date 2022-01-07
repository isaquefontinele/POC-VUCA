import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poc_vuca/components/loadingDialog.dart';
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
      child: Scaffold(
          body: Center(
            child: Expanded(
              child: SizedBox (
                width: 200,
                child: Container(
                  color: Colors.amber,
                  child: ListView.builder(
                    itemCount: mainMenu!= null ? mainMenu!.categories!.length : 0,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text("${mainMenu!.categories![i].desc}"),
                      );
                    },
                  ),
                ),
              )
            )
          )
      ),
    );
  }

  void loadMenu() {
    Future.delayed(Duration.zero, () {
      LoadingDialog.show(context);
    });
    GetMenuService().getFullMenu().then((menu) {
      Navigator.pop(context);
      setState(() {
        mainMenu = menu;
      });
    });
  }
}
