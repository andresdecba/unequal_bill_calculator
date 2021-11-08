import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:bill_calculator/states/singleton.dart';

Future whatsappLauncher(BuildContext context, bool isActive) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        title: 'Enviar por WhatsApp',
        children: [
          isActive == true ? const ByTotal() : const ByItem(),
        ],
      );
    },
  );
}

//////////// SEND DETAIL BY ITEMS ///////////////
class ByItem extends StatefulWidget {
  const ByItem({Key? key}) : super(key: key);
  @override
  State<ByItem> createState() => _ByItemState();
}

class _ByItemState extends State<ByItem> {
  //
  // texto a enviar
  final usersList = Singleton().listaUsuarios;
  String createWappText = '';

  @override
  void initState() {
    super.initState();

    // get total by user
    for (var user in usersList) {
      String expenseDetails = '';

      // get services by user
      for (var expense in user.servicios) {
        expenseDetails += '- _${expense.servicio.servicioNombre}: \$ ${expense.aPagar} (x${expense.multiplicarPor})_ \n';
      }

      String total = '*${user.userNombre}: \$${user.totalAPagar}*\n$expenseDetails\n';
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
        kDivder,
        Text(
          createWappText,
          style: kTextXS,
          maxLines: 10,
          overflow: TextOverflow.fade,
        ),
        kDivder,
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
      text: 'Totales a pagar:\n\n' + createWappText + 'Calculado con play.google.com/store/apps/details?id=com.calculadora.desigual',
    );
    await launch('$link');
  }
}

//////////// SEND DETAIL BY TOTAL ///////////////
class ByTotal extends StatefulWidget {
  const ByTotal({Key? key}) : super(key: key);
  @override
  State<ByTotal> createState() => _ByTotalState();
}

class _ByTotalState extends State<ByTotal> {
  //
  // users data
  final lista = Singleton().listaUsuarios;
  String textToWhatsapp = '';

  @override
  void initState() {
    super.initState();

    // get total by user
    lista.map((e) {
      return textToWhatsapp += '*${e.userNombre}: \$${e.totalAPagar}* _(x${e.totalDivider})_\n';
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
        kDivder,
        Text(
          textToWhatsapp,
          style: kTextXS,
          maxLines: 6,
          overflow: TextOverflow.fade,
        ),
        kDivder,
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
      text: 'Totales a pagar:\n\n' + textToWhatsapp + '\nCalculado con play.google.com/store/apps/details?id=com.tienda.online',
    );

    await launch('$link');
  }
}
