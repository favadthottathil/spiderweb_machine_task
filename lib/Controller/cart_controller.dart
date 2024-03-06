import 'package:e_commerce_machine_test/Model/cart.dart';
import 'package:e_commerce_machine_test/Model/products_model.dart';
import 'package:flutter/material.dart';

class CartController {
  ValueNotifier<List<Cart>> get cartNotifier => Cart.cartList;

  addToCart(Products product) {
    Cart.addToCart(product);
  }

  getAllCartList() async {
    await Cart.getCartList();
  }

  removeFromCart(Cart cart) async {
    await Cart.removeFromCart(cart);
  }
}
