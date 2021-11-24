import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: cancelButtonDecoration(),
      child: const Text(
        '> cancelar',
        style: kButtonsText,
      ),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }
}
