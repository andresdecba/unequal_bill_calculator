import 'package:bill_calculator/styles/colors.dart';
import 'package:flutter/material.dart';

IconButton kIconButton({required VoidCallback onPress, required IconData icon}) {
  return IconButton(
    onPressed: onPress,
    padding: EdgeInsets.zero,
    alignment: Alignment.center,
    icon: Icon(
      icon,
      color: kNegro,
    ),
  );
}
