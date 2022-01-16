import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imageURL;
  final double height;

  CardImage(this.imageURL, this.height);

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: FadeInImage.assetNetwork(
        height: height,
        width: MediaQuery.of(context).size.width,
        placeholder: 'assets/placeholder_dark.png',
        image: imageURL,
        fit: BoxFit.fitWidth,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/placeholder_dark.png', fit: BoxFit.fitWidth, height: 100, width: MediaQuery.of(context).size.width);
        },
      ),
    );
  }
}
