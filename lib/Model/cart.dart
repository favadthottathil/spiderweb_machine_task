import 'package:e_commerce_machine_test/Constants/global_variables.dart';
import 'package:e_commerce_machine_test/Model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'cart.g.dart';

@HiveType(typeId: 2)
class Cart with ChangeNotifier {
  @HiveField(0)
  int id;
  @HiveField(1)
  int count;
  @HiveField(2)
  Products product;

  Cart({required this.id, required this.count, required this.product});

  static ValueNotifier<List<Cart>> cartList = ValueNotifier([]);

  static Future<void> addToCart(Products product) async {
    // OPEN DATABASE
    final cartDb = await Hive.openBox<Cart>(CART_DATABASE_NAME);

    final foundedList = cartDb.values.where((cartItem) => product.id == cartItem.id).toList();

    if (foundedList.isNotEmpty) {
      // If the product is already in the cart, update its count
      Cart cart = foundedList[0];
      cart.count += 1;
      await cartDb.put(cart.id, cart);
    } else {
      // If the product is not in the cart, add it
      Cart cart = Cart(id: product.id, count: 1, product: product);
      await cartDb.put(cart.id, cart);
    }
    // Refresh the cart list
    await getCartList();
  }

  static getCartList() async {
    final cartDb = await Hive.openBox<Cart>(CART_DATABASE_NAME);

    cartList.value.clear();

    cartList.value.addAll(cartDb.values);
    cartList.notifyListeners();
  }

  static removeFromCart(Cart cart) async {
    final cartDb = await Hive.openBox<Cart>(CART_DATABASE_NAME);

    final foundedList = cartDb.values.where((cartItem) => cartItem.id == cart.id).toList();

    if (foundedList.isNotEmpty) {
      Cart cart = foundedList[0];
      if (cart.count == 1) {
        // If the count is 1, remove the item from the cart
        await cartDb.delete(cart.id);
      } else {
        // If the count is more than 1, decrement the count
        cart.count -= 1;
        await cartDb.put(cart.id, cart);
      }
    }
    // Refresh the cart list
    getCartList();
  }
}
