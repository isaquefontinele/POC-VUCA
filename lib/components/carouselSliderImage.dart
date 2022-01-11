import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:poc_vuca/models/menu.dart';

class ImageSlider extends StatefulWidget {
  final List<MenuItem?> itemList;

  ImageSlider(this.itemList);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 300,
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                aspectRatio: 2.0,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: widget.itemList
                  .map((item) => Container(
                        child: Center(
                            child: Stack(
                          children: [
                            Align(
                              child: Image.network(item!.thumb![0],
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width / 2),
                              alignment: Alignment.bottomCenter,
                            ),
                            Align(child: Text(
                              item.desc!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow( // bottomLeft
                                        offset: Offset(-1.5, -1.5),
                                        color: Colors.black
                                    ),
                                    Shadow( // bottomRight
                                        offset: Offset(1.5, -1.5),
                                        color: Colors.black
                                    ),
                                    Shadow( // topRight
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.black
                                    ),
                                    Shadow( // topLeft
                                        offset: Offset(-1.5, 1.5),
                                        color: Colors.black
                                    ),
                                  ]),
                            ),
                            alignment: Alignment.bottomCenter,)
                          ],
                        )),
                      ))
                  .toList(),
            )),
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.itemList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
