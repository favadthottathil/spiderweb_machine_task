import 'package:e_commerce_machine_test/View/All%20Proucts/Widgets/single_product.dart';
import 'package:e_commerce_machine_test/Controller/cart_controller.dart';
import 'package:e_commerce_machine_test/Controller/product_controller.dart';
import 'package:e_commerce_machine_test/View/Cart/Screens/cart_screen.dart';
import 'package:e_commerce_machine_test/View/Details%20Screen/Screens/details_screen.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  AllProducts({super.key});

  final ProductController _productController = ProductController();

  final CartController _cartController = CartController();

  initDb() async {
    if (await _productController.isDbExist() == false) {
      _productController.addProducts();
    }
  }

  initCartDb() {
    _cartController.getAllCartList();
  }

  @override
  Widget build(BuildContext context) {
    initDb();
    initCartDb();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('All Products'),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              ),
              child: ValueListenableBuilder(
                  valueListenable: _cartController.cartNotifier,
                  builder: (context, cartList, _) {
                    return badge.Badge(
                      badgeContent: Text(
                        cartList.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: const badge.BadgeStyle(
                        badgeColor: Colors.black,
                      ),
                      child: const Icon(Icons.card_travel),
                    );
                  }),
            )
          ],
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: _productController.productNotifier,
          builder: (context, products, _) {
            if (products.isEmpty) {
              return const Center(child: Text('List Is Empty'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: products[index],
                            ),
                          )),
                      child: SingleProduct(product: products[index]),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
