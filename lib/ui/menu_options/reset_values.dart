import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future resetValues(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return const DialogBox(
        title: 'Resetear divisores',
        children: ResetValues(),
      );
    },
  );
}

class ResetValues extends StatelessWidget {
  const ResetValues({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provider
    final _state = Provider.of<CalculateScreenState>(context);

    return Column(
      children: [
        kDivider,
        const Text('Todos los divisores se pondran en 1', style: kTextSmall),
        kDivider,
        kSizedBoxBig,
        ElevatedButton(
          style: buttonDecoration(),
          child: const Text(
            '> resetear',
            style: kButtonsText,
          ),
          onPressed: () async {
            await _state.resetDividers();
            Navigator.pop(context);
            //Navigator.of(context).popUntil(ModalRoute.withName("/createUsers"));
          },
        ),
        const CancelButton(),
      ],
    );
  }
}
