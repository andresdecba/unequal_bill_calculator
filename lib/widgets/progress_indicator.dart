import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

class ProgressIndicartor extends StatelessWidget {
  const ProgressIndicartor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: CircularProgressIndicator(
        color: kGris300,
      ),
      width: 20,
      height: 20,
    );
  }
}
