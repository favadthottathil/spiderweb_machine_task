import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.ontap,
    this.isAdd = false,
  });

  final VoidCallback ontap;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: CircleAvatar(
        radius: 12,
        child: Icon(
          isAdd ? Icons.add : Icons.remove,
          size: 16,
        ),
      ),
    );
  }
}
