import 'package:e_commerce_machine_test/Model/cart.dart';
import 'package:e_commerce_machine_test/Model/products_model.dart';
import 'package:e_commerce_machine_test/View/All%20Proucts/Screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init Flutter
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ProductsAdapter().typeId)) {
    Hive.registerAdapter(ProductsAdapter());
  }

  if (!Hive.isAdapterRegistered(CartAdapter().typeId)) {
    Hive.registerAdapter(CartAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AllProducts(),
    );
  }
}
