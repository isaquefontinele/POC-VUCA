import 'package:flutter/material.dart';
import 'package:poc_vuca/models/cart.dart';
import 'package:poc_vuca/utils/appColors.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cart cart = Cart();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        color: AppColors.grayDarkCategories,
        child: Column(
          children: [
            ListView.builder(
              itemCount: cart.products.length,
              shrinkWrap: true,
              itemBuilder: (context, i){
                  return ListTile(
                    title: Text(cart.products[i].desc!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text("Adicionar mais itens ao carrinho.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() {
    Navigator.pop(context);
  }
}
