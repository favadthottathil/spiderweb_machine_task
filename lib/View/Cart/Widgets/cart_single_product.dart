import 'package:e_commerce_machine_test/Controller/cart_controller.dart';
import 'package:e_commerce_machine_test/Controller/product_controller.dart';
import 'package:e_commerce_machine_test/Model/cart.dart';
import 'package:e_commerce_machine_test/Utils/utils.dart';
import 'package:e_commerce_machine_test/View/Cart/Widgets/cart_button.dart';
import 'package:flutter/material.dart';

class CartSingleProduct extends StatelessWidget {
  const CartSingleProduct({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = CartController();

    final ProductController productController = ProductController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  cart.product.imageUrl,
                  fit: BoxFit.fitHeight,
                  width: 180,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cart.product.name),
                    Text('\$${cart.product.price}'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartButton(
                    ontap: () {
                      cartController.removeFromCart(cart);
                      showSnackbar(context, 'product count decremented');
                    },
                  ),
                  const SizedBox(width: 6),
                  ValueListenableBuilder(
                      valueListenable: cartController.cartNotifier,
                      builder: (context, cartlist, _) {
                        final data = cartlist.firstWhere((cartItem) => cartItem.id == cart.id);

                        return Text(data.count.toString());
                      }),
                  const SizedBox(width: 6),
                  CartButton(
                    ontap: () {
                      final product = productController.productNotifier.value
                          .where(
                            (product) => product.id == cart.id,
                          )
                          .toList();

                      cartController.addToCart(product.first);
                      showSnackbar(context, 'product count incremented');
                    },
                    isAdd: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
