import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

class SubstractAddButtons extends StatelessWidget {
  const SubstractAddButtons({
    Key? key,
    required this.isLoading,
    required this.sunstractBttn,
    required this.quantity,
    required this.addBttn,
  }) : super(key: key);

  final bool isLoading;
  final VoidCallback sunstractBttn;
  final String quantity;
  final VoidCallback addBttn;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading, //_state.isLoading,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///// restar button
          kIconButton(
            onPress: sunstractBttn,
            icon: Icons.remove_circle,
          ),
          kSizedBoxBig,
          ///// divisor text
          Text(
            quantity,
            style: kTextSmall,
          ),
          kSizedBoxBig,
          ///// sumar button
          kIconButton(
            onPress: addBttn,
            icon: Icons.add_circle,
          )
        ],
      ),
    );
  }
}
