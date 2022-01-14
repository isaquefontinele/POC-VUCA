import 'package:flutter/material.dart';
import 'package:poc_vuca/components/marquee.dart';
import 'package:poc_vuca/models/menu.dart';

import 'cardImage.dart';

class ProductsListDialog {
  static open(BuildContext context, Category selectedCategory) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.8), // Background color
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        return Stack(
          children: <Widget>[
            Center(child: SizedBox(
                height: 400,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: selectedCategory.products!.length,
                    padding: EdgeInsets.only(bottom: 12),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var product = selectedCategory.products![index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Container(
                            width: 300,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(color: Colors.transparent),
                            child: Card(
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: (Column(
                                children: [
                                  CardImage(product.ft![0], 200),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Marquee(
                                      direction: Axis.horizontal,
                                      child: Text(product.desc!, textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(thickness: 1, height: 1,),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(product.descr!, textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    })
            )),
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
      },
    );
  }
}