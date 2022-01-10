import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poc_vuca/components/cardImage.dart';
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
          child: SingleChildScrollView(
            child:
            mainMenu == null ? Container() : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: [banner(), categoriesList()],
                      ),
                      Divider(height: 1, thickness: 1, color: Colors.black),
                      homeMenu(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
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
      child: (Expanded(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: mainMenu!.categories!.length,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 10),
                  child: Text("${mainMenu!.categories![i].desc}"),
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  Widget homeMenu() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: mainMenu!.categories!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            mainMenu!.categories![i].desc!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  mainMenu!.categories![i].products!.length,
                              itemBuilder: (_, j) {
                                var product =
                                    mainMenu!.categories![i].products![j];
                                return carouselItem(product);
                              }),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(category.desc!),
      ));
    });
  }

  Widget carouselItem(MenuItem product) {
    var picture = product.thumb != null && product.thumb!.length > 0
        ? product.thumb![0]
        : "";
    return InkWell(
      onTap: () => openProduct(product),
      child: Container(
        width: 150,
        child: Card(
            child: (Column(
          children: [CardImage(picture), Text(product.desc!)],
        ))),
      ),
    );
  }

  openProduct(MenuItem product) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(product.desc!),
      ));
    });
  }
}
