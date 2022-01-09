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
          body: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            Column(
                              children: [
                                banner(),
                                categoriesList()
                            ],),
                            Divider(height: 1, thickness: 1, color: Colors.black),
                            homeMenu(),
                          ],),
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
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

  Widget categoriesList() {
    return Container(
      height: 60,
      color: Colors.red,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mainMenu!= null ? mainMenu!.categories!.length : 0,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () => goToCategory(mainMenu!.categories![i]),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text("${mainMenu!.categories![i].desc}"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homeMenu() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
      ),
    );
  }

  Widget banner() {
    return Container(
      height: 200,
      color: Colors.redAccent,
    );
  }

  goToCategory(Category category) {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(category.desc!),
      ));
    });

  }
}
