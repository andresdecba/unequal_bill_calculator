import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future changeBillTitle(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        title: 'Cambiar el título de la cuenta',
        children: ChangeTitle(),
      );
    },
  );
}

class ChangeTitle extends StatelessWidget {
  ChangeTitle({Key? key}) : super(key: key);

  final _textController = TextEditingController();
  String _newBillName = '';

  @override
  Widget build(BuildContext context) {
    // provider
    final _state = Provider.of<CreateNewBillScreenState>(context);

    return Column(
      children: [
        // TEXT FORM
        TextFormField(
          controller: _textController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          decoration: inputDecoration(controller: _textController, hintText: 'Nueva_cuenta'),
          onChanged: (value) => _newBillName = value,
          onFieldSubmitted: (value) => _newBillName = value,
        ),
        kSizedBoxBig,

        // BUTTONS
        ElevatedButton(
          style: buttonDecoration(),
          child: const Text(
            '> cambiar',
            style: kButtonsText,
          ),
          onPressed: () async {
            await _state.updateBillName(newName: _newBillName);
            Navigator.pop(context);
            //Navigator.of(context).popUntil(ModalRoute.withName("/createUsers"));
          },
        ),

        const CancelButton(),
      ],
    );
  }
}
