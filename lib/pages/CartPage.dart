import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poc_vuca/models/cart.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/utils/appColors.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Cart cart = Cart();
  final currencyFormatter = new NumberFormat("#,##0.00", "pt_BR");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: AppColors.grayBanner,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width -316,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: cart.products.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i){
                    return Card(
                      margin: EdgeInsets.all(20),
                      color: AppColors.grayDarkCategories,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Container(
                              child: Text(cart.products[i].desc!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              width: 250,
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Text("R\$ "+ currencyFormatter.format(cart.products[i].val),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text("Qnt: " + cart.amounts[cart.products[i].id].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            InkWell(
                              onTap: () => removeProduct(cart.products[i]),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(Icons.close,size: 20, color: Colors.yellow),
                              ),
                            )
                          ],
                        ),
                      )
                    );
                },
              ),
            ),
            VerticalDivider(color: Colors.grey,),
            Container(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Icon(Icons.shopping_cart,size: 50, color: Colors.white),
                    ),
                    Text("Total: " + "R\$ "+ currencyFormatter.format(cart.getTotalValue()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: addMoreItems,
                        child: Text("Adicionar mais itens ao carrinho.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),),
                    ),
                    Container(
                      width: 200,
                      height: 100,
                      margin: EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: sendOrder,
                        child: Text("Enviar pedido.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addMoreItems() {
    Navigator.pop(context);
  }

  sendOrder() {
    if (cart.products.length > 0) {
      Navigator.pop(context);
      cart.clearCart();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text("Pedido enviado."),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text("Carrinho vazio."),
      ));
    }
  }

  removeProduct(MenuItem product) {
    cart.removeProductFromCart(product);
    setState(() {});
  }
}
