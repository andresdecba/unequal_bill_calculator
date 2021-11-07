import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({required this.title, required this.children, Key? key}) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    //get screen size

    return SimpleDialog(
      elevation: 5,
      insetPadding: kPaddingSmall,
      contentPadding: kPaddingSmall,
      backgroundColor: kAmarillo,
      alignment: Alignment.center,
      title: Text(
        '> $title',
        style: kTextLarge,
        //textAlign: TextAlign.center,
      ),
      children: children,
    );
  }
}
