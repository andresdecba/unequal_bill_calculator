import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future deleteAndCreateNewBill(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return const DialogBox(
        title: 'Crear una nueva cuenta',
        children: DeleteAndCreateNewBill(),
      );
    },
  );
}

class DeleteAndCreateNewBill extends StatelessWidget {
  const DeleteAndCreateNewBill({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provider
    final _newBillstate = Provider.of<CreateNewBillScreenState>(context);

    return Column(
      children: [
        const SizedBox(width: double.infinity),
        kDivider,
        const Text('Se perderán todos los datos para comenzar una nueva cuenta ', style: kTextSmall),
        kDivider,
        kSizedBoxBig,
        ElevatedButton(
          style: buttonDecoration(),
          child: const Text(
            '> crear nueva',
            style: kButtonsText,
          ),
          onPressed: () async {
            await _newBillstate.resetApp(context);
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        const CancelButton(),
      ],
    );
  }
}
