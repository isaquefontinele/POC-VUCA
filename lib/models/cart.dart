import 'package:poc_vuca/models/menu.dart';

class Cart {
  static final Cart _singleton = Cart._internal();

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

  List<MenuItem> products = [];
  Map<String, int> amounts = Map();

  double getTotalValue(){
    return products.map((menuItem) => menuItem).fold(0.0, (previousValue, element) {
      return previousValue + (element.val! * amounts[element.id]!);
    });
  }

  void addProductToCart(MenuItem product) {
    if (amounts.keys.contains(product.id)) {
      amounts.update(product.id!, (value) => value + product.amount!);
    } else {
      products.add(product);
      amounts[product.id!] = product.amount!;
    }
  }

  void removeProductFromCart(MenuItem product) {
    products.remove(product);
    amounts.remove(product.id);
  }

  void clearCart() {
    products.clear();
    amounts.clear();
  }
}