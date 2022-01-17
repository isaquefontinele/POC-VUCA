import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poc_vuca/components/marquee.dart';
import 'package:poc_vuca/models/cart.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/utils/appColors.dart';

import 'cardImage.dart';

class ProductsListDialog {

  static open(BuildContext context, Category selectedCategory) async {
    await showGeneralDialog<String>(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.8),
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 400),
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        tween = Tween(begin: Offset(0, 1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
      pageBuilder: (_, __, ___) {
        return ProductsListContent(selectedCategory: selectedCategory);
      },
    );
  }
}

class ProductsListContent extends StatefulWidget {

  final Category selectedCategory;

  const ProductsListContent({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  _ProductsListContentState createState() => _ProductsListContentState();
}

class _ProductsListContentState extends State<ProductsListContent> {

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Stack(
        children: <Widget>[
          productList(widget.selectedCategory),
          closeDialogButton()
        ],
      ),
    );
  }

  Widget productList(Category selectedCategory) {
    return Center(
        child: SizedBox(
            height: 410,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: selectedCategory.products!.length,
                padding: EdgeInsets.only(bottom: 12),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var product = selectedCategory.products![index];
                  var picture =
                  product.ft != null && product.ft!.isNotEmpty
                      ? product.ft![0]
                      : "";
                  final currencyFormatter = new NumberFormat("#,##0.00", "pt_BR");
                  return Container(
                    width: 400,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration:
                    BoxDecoration(color: Colors.transparent),
                    child: Card(
                      color: AppColors.grayDarkCategories,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: (Column(
                        children: [
                          SizedBox(
                            child: CardImage(picture, 200),
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 8),
                            child: Marquee(
                              direction: Axis.horizontal,
                              child: Text(product.desc!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Divider(
                              color: AppColors.grayBanner,
                              thickness: 1,
                              height: 1,
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(10),
                                  child: Text(product.descr!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Divider(
                              color: AppColors.grayBanner,
                              thickness: 1,
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  color: AppColors.grayBanner,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => {
                                          if (product.amount! > 1)
                                            {
                                              setState(() {
                                                product.amount = product.amount!-1;
                                              })
                                            }
                                        },
                                        child: counterButton("-"),
                                      ),
                                      Text(
                                          product.amount.toString(),
                                          textAlign:
                                          TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.bold,
                                              color:
                                              Colors.white)),
                                      InkWell(
                                        onTap: () => {
                                          if (product.amount! <=
                                              999)
                                            {
                                              setState(() {
                                                product.amount = product.amount!+1;
                                              })
                                            }
                                        },
                                        child: counterButton("+"),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(flex: 1,),
                                InkWell(
                                  onTap: () => addToCart(product),
                                  child: Container(
                                    height: 40,
                                    color: AppColors.grayBanner,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      child: Row(children: [
                                        Icon(Icons.add_shopping_cart,size: 20, color: Colors.white),
                                        Padding(padding: EdgeInsets.only(right: 10)),
                                        Text(
                                            "Adicionar",
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold,
                                                color:
                                                Colors.white)),
                                        Padding(padding: EdgeInsets.only(right: 10)),
                                        Text(
                                            "R\$ "+ currencyFormatter.format(product.amount! * product.val!),
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold,
                                                color:
                                                Colors.white)),
                                      ],),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                  );
                })));
  }

  Widget counterButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(text,
          textAlign: TextAlign
              .center,
          style: TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight
                  .bold,
              color: Colors
                  .white)),
    );
  }

  Widget closeDialogButton() {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, top: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.red, // <-- Button color
              onPrimary: Colors.white, // <-- Splash color
            ),
            onPressed: () => resetAndClose(),
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  resetAndClose() {
    widget.selectedCategory.resetAmounts();
    Navigator.pop(context);
  }

  addToCart(MenuItem product) {
    Cart cart = Cart();
    setState(() {
      cart.addProductToCart(product);
    });
    // resetAndClose();
    Navigator.popAndPushNamed(context, "/cart");
  }
}
