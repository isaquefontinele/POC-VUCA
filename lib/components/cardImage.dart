import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imageURL;

  CardImage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: FadeInImage.assetNetwork(
        height: 100,
        width: MediaQuery.of(context).size.width,
        placeholder: 'assets/placeholder.png',
        image: imageURL,
        fit: BoxFit.fitWidth,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/placeholder.png', fit: BoxFit.fitWidth, height: 100, width: MediaQuery.of(context).size.width);
        },
      ),
    );
  }
}
