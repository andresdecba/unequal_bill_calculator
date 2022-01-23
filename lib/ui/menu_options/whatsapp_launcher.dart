import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

Future whatsappLauncher(BuildContext context, bool isActive) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        title: 'Enviar por WhatsApp',
        children: isActive == true ? const ByTotal() : const ByItem(),
      );
    },
  );
}

//////////// SEND DETAIL BY ITEMS ///////////////
class ByItem extends StatefulWidget {
  const ByItem({Key key}) : super(key: key);
  @override
  State<ByItem> createState() => _ByItemState();
}

class _ByItemState extends State<ByItem> {
  //
  // texto a enviar
  final usersList = Singleton().usersBOX.values;
  final expensesList = Singleton().expensesBOX.values;

  String createWappText = '*${Singleton().billBOX.values.first.billName}*\n';

  @override
  void initState() {
    super.initState();

    // build expenses list
    for (var item in expensesList) {
      createWappText += '*${item.expenseName}: \$${item.expensePrice}*\n';
    }
    // add total
    createWappText += '*>Total: \$${Singleton().billBOX.values.first.billTotal}*\n\n';

    // build total by user
    for (var user in usersList) {
      String expenseDetails = '';

      // get services by user
      for (var expense in user.userExpensesList) {
        expenseDetails += '- _${expense.userExpenseExpense.first.expenseName}: \$ ${expense.userExpenseTotal} (x${expense.userExpenseByItemFactor})_ \n';
      }

      String total = '*${user.userName}: \$${user.userTotalByItem}*\n$expenseDetails\n';
      createWappText += total;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Se enviará total por persona con sus items ',
          style: kTextSmall,
        ),
        kDivider,
        Text(
          createWappText,
          style: kTextXS,
          maxLines: 10,
          overflow: TextOverflow.fade,
        ),
        kDivider,
        ElevatedButton(
          style: buttonDecoration(),
          onPressed: () => _launchWhatsAppComplete(),
          child: const Text('> Enviar'),
        ),
      ],
    );
  }

  //////// send details of each service to pay by user ////////
  _launchWhatsAppComplete() async {
    final link = WhatsAppUnilink(
      phoneNumber: '',
      text: createWappText + 'Calculado con play.google.com/store/apps/details?id=com.calculadora.desigual',
    );
    await launch('$link');
  }
}

//////////// SEND DETAIL BY TOTAL ///////////////
class ByTotal extends StatefulWidget {
  const ByTotal({Key key}) : super(key: key);
  @override
  State<ByTotal> createState() => _ByTotalState();
}

class _ByTotalState extends State<ByTotal> {
  //
  // users data
  final lista = Singleton().usersBOX.values;
  final expensesList = Singleton().expensesBOX.values;

  String textToWhatsapp = '*${Singleton().billBOX.values.first.billName}*\n';

  @override
  void initState() {
    super.initState();

    // build expenses list
    for (var item in expensesList) {
      textToWhatsapp += '*${item.expenseName}: \$${item.expensePrice}*\n';
    }
    // add total
    textToWhatsapp += '*>Total: \$${Singleton().billBOX.values.first.billTotal}*\n\n';

    // build total by user
    lista.map((e) {
      return textToWhatsapp += '*${e.userName}: \$${e.userTotalByGlobal}* _(x${e.userByGlobalFactor})_\n';
    }).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Se enviará el total por persona',
          style: kTextSmall,
        ),
        kDivider,
        Text(
          textToWhatsapp,
          style: kTextXS,
          maxLines: 6,
          overflow: TextOverflow.fade,
        ),
        kDivider,
        ElevatedButton(
          style: buttonDecoration(),
          onPressed: () => _launchWhatsAppSimple(),
          child: const Text('> Enviar'),
        ),
      ],
    );
  }

  //////// send total by user ////////
  _launchWhatsAppSimple() async {
    final link = WhatsAppUnilink(
      phoneNumber: '',
      text: textToWhatsapp + '\nCalculado con play.google.com/store/apps/details?id=com.tienda.online',
    );

    await launch('$link');
  }
}
