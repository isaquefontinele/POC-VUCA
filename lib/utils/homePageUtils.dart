import 'package:poc_vuca/models/menu.dart';

class HomeUtils {

  static List<MenuItem?> getCoverImages(Menu mainMenu) {
    return mainMenu.categories!
        .firstWhere((element) => element.id == "1")
        .products!
        .map((product) => product.thumb!.length > 0 ? product : null)
        .where((element) => element != null)
        .toList();
  }
}