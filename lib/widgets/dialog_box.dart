import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({this.title, this.children, Key key}) : super(key: key);

  final String title;
  final Widget children;

  @override
  Widget build(BuildContext context) {
    //get screen size
    final _screenData = MediaQuery.of(context).size.width;

    return SimpleDialog(
      elevation: 5,
      //insetPadding: kPaddingSmall,
      contentPadding: kPaddingSmall,
      backgroundColor: kAmarillo,
      alignment: Alignment.center,
      title: Text(
        '> $title',
        style: kTextLarge,
      ),
      children: [
        SizedBox(
          width: _screenData,
        ),
        children,
      ],
    );
  }
}
