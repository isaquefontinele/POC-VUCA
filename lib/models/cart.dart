import 'package:poc_vuca/models/menu.dart';

class Cart {
  static final Cart _singleton = Cart._internal();

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

  List<MenuItem> products = List.empty();
  Map<String, int> amounts = Map();

  double getTotalValue(){
    return products.map((menuItem) => menuItem).fold(0.0, (previousValue, element) {
      return previousValue + (element.val! * amounts[element.id]!);
    });
  }

  void addProductToCart(MenuItem product) {
    if (products.contains(product)) {
      amounts.update(product.id!, (value) => value++);
    } else {
      products.add(product);
      amounts[product.id!] = 1;
    }
  }

  void removeProductFromCart(MenuItem product) {
    if (amounts[product.id!] == 1) {
      products.remove(product);
      amounts.remove(product.id);
    } else {
      amounts.update(product.id!, (value) => value--);
    }
  }

  void clearCart() {
    products.clear();
    amounts.clear();
  }
}