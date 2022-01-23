import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class CreateNewBillScreen extends StatelessWidget {
  CreateNewBillScreen({Key key}) : super(key: key);

  String _billName;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //get screen size
    final _screenData = MediaQuery.of(context);
    // provider
    final _state = Provider.of<CreateNewBillScreenState>(context);

    return Scaffold(
      backgroundColor: kAmarillo,
      body: ListView(
        padding: kPaddingLarge,
        shrinkWrap: true,
        children: [
          // logo
          Container(
            height: _screenData.size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Image.asset(
              'assets/images/app_logo_black.png',
            ),
          ),

          // text field
          TextFormField(
            controller: _textController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            decoration: inputDecoration(controller: _textController, hintText: 'Cuenta nueva (${getDate()})'),
            onChanged: (value) => _billName = value,
            onFieldSubmitted: (value) => _billName = value,
          ),
          kSizedBoxBig,

          // button
          ElevatedButton(
            style: buttonDecoration(),
            child: const Text(
              '> continuar',
              style: kButtonsText,
            ),
            onPressed: () async {
              await _state.createNewBill(billName: _billName);
              Navigator.pushNamedAndRemoveUntil(context, '/createUsers', (route) => false);
            },
          ),

          // message
          Container(
            padding: kPaddingLarge,
            alignment: Alignment.center,
            child: const Text(
              'Si lo desea, puede agregar un título a su cuenta (opcional)',
              style: kTextSmall,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
