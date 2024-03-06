import 'package:e_commerce_machine_test/Controller/cart_controller.dart';
import 'package:e_commerce_machine_test/Model/products_model.dart';
import 'package:e_commerce_machine_test/Utils/utils.dart';
import 'package:e_commerce_machine_test/View/Details%20Screen/Widget/product_image.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(image: product.imageUrl),
              const SizedBox(height: 20),
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '\$ ${product.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.description,
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    CartController().addToCart(product);
                    showSnackbar(context, 'Product Added To Cart');
                  },
                  icon: const Icon(Icons.badge),
                  label: const Text('Add to Cart'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
