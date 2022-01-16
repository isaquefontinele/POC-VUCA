import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poc_vuca/components/marquee.dart';
import 'package:poc_vuca/models/cart.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/utils/appColors.dart';

import 'cardImage.dart';
List<String> countries = <String>['Belgium','France','Italy','Germany','Spain','Portugal'];

class ProductsListDialog {


  static open(BuildContext context, Category selectedCategory) async {
    await showDialog<String>(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.8),
      barrierDismissible: false,
      builder: (BuildContext context) {
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
    Category selectedCategory = widget.selectedCategory;
    Cart cart = Cart();

    return Stack(
      children: <Widget>[
        Center(
            child: SizedBox(
                height: 400,
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
                      return Container(
                        width: 300,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height,
                        decoration:
                        BoxDecoration(color: Colors.transparent),
                        child: Card(
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: (Column(
                            children: [
                              SizedBox(
                                child: CardImage(picture, 200),
                                height: 200,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Marquee(
                                  direction: Axis.horizontal,
                                  child: Text(product.desc!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Divider(
                                  thickness: 1,
                                  height: 1,
                                ),
                              ),
                              SizedBox(
                                height: 100,
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
                                              color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
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
                                  ],
                                ),
                              )
                            ],
                          )),
                        ),
                      );
                    }))),
        Align(
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
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.close),
              ),
            ),
          ),
        ),
      ],
    );
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
}
