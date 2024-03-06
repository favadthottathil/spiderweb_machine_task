import 'package:e_commerce_machine_test/Constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'products_model.g.dart';

@HiveType(typeId: 1)
class Products with ChangeNotifier {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String imageUrl;

  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  static ValueNotifier<List<Products>> allProducts = ValueNotifier([]);

  static Future<void> addProduct({required Products product}) async {
    // OPEN DATABASE
    try {
      final productDb = await Hive.openBox<Products>(PRODUCTS_DATABASE_NAME);

      final key = await productDb.add(product);

      product.id = key;

      productDb.put(key, product);

      await getAllProducts();
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> getAllProducts() async {
    try {
      final productDb = await Hive.openBox<Products>(PRODUCTS_DATABASE_NAME);

      allProducts.value.clear();

      allProducts.value.addAll(productDb.values);

      allProducts.notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }
}
