import 'package:e_commerce_machine_test/Constants/global_variables.dart';
import 'package:e_commerce_machine_test/Model/products_model.dart';
import 'package:flutter/material.dart';

class ProductController {
  // get productNotifier
  ValueNotifier<List<Products>> get productNotifier => Products.allProducts;

  addProducts() async {
    for (var product in productList) {
      await Products.addProduct(product: product);
    }
  }

  isDbExist() async {
    await Products.getAllProducts();
    if (productNotifier.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
