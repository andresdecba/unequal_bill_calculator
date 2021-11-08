import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

SnackBar snackBarCustom({required String message}) {
  return SnackBar(
    duration: const Duration(milliseconds: 1000),
    padding: kPaddingLarge,
    backgroundColor: kAzul,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.warning,
          color: Colors.black,
        ),
        Text(
          message,
          style: kTextSmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
