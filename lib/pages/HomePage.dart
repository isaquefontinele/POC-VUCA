import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poc_vuca/components/cardImage.dart';
import 'package:poc_vuca/components/carouselSliderImage.dart';
import 'package:poc_vuca/components/loadingDialog.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/utils/appColors.dart';
import 'package:poc_vuca/utils/homePageUtils.dart';
import 'package:poc_vuca/webservices/vuca/getMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Menu? mainMenu;
  late bool showCategoryDetails;

  @override
  void initState() {
    super.initState();
    loadMenu();
    showCategoryDetails = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
              child: mainMenu == null ? Container() : homeContent()),
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

  Widget homeContent() {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  banner(),
                  Divider(height: 1, thickness: 1, color: Colors.black),
                  categoriesList(),
                  Divider(height: 1, thickness: 1, color: Colors.black),
                  homeMenu(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget categoriesList() {
    return Container(
      height: 60,
      color: AppColors.grayDarkCategories,
      child: Expanded(
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
                  borderRadius: BorderRadius.circular(10),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: AppColors.grayBanner,
            child: SizedBox(
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
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
                                  return carouselItem(i, j);
                                }),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget banner() {
    return Container(
      height: 330,
      width: MediaQuery.of(context).size.width,
      color: AppColors.grayBanner,
      child: ImageSlider(HomeUtils.getCoverImages(mainMenu!)),
    );
  }

  Widget carouselItem(int i, int j) {
    var category = mainMenu!.categories![i];
    var product = category.products![j];
    var picture = product.thumb != null && product.thumb!.length > 0
        ? product.thumb![0]
        : "";
    return InkWell(
      onTap: () => openProduct(category),
      child: Container(
        width: 150,
        child: Card(
            child: (Column(
          children: [CardImage(picture), Text(product.desc!, textAlign: TextAlign.center)],
        ))),
      ),
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

  openProduct(Category category) {
    productListDialog(category);
  }

  productListDialog(Category selectedCategory) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          primary: Colors.red, // <-- Button color
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                    height: MediaQuery.of(context).size.height - 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: selectedCategory!.products!.length,
                        padding: EdgeInsets.only(bottom: 12),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var product = selectedCategory!.products![index];
                          return Material(
                            child: InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 140,
                                decoration: BoxDecoration(color: Colors.transparent),
                                child: Card(
                                    child: (Column(
                                      children: [CardImage(product.ft!), Text(product.desc!, textAlign: TextAlign.center)],
                                    ))),
                              ),
                              onTap: () {},
                            ),
                          );
                        })
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}