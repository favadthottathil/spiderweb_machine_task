import 'package:e_commerce_machine_test/Controller/cart_controller.dart';
import 'package:e_commerce_machine_test/View/Cart/Widgets/cart_single_product.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = CartController();

  @override
  void initState() {
    super.initState();
    getCartData();
  }

  getCartData() async {
    await cartController.getAllCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carts'),
      ),
      body: ValueListenableBuilder(
          valueListenable: cartController.cartNotifier,
          builder: (context, carts, _) {
            if (carts.isEmpty) {
              return const Center(child: Text('Cart Is Empty'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: carts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return CartSingleProduct(cart: carts[index]);
                  },
                ),
              );
            }
          }),
    );
  }
}
