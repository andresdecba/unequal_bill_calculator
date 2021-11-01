import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:bill_calculator/states/singleton.dart';

Future showInformationDialog(BuildContext context) async {
  
  return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Enviar por wapp'),
          alignment: Alignment.center,
          contentPadding: const EdgeInsets.all(30),
          insetPadding: const EdgeInsets.all(30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
          children: [
            ElevatedButton(
              onPressed: () => _launchWhatsAppSimple(),
              child: const Text('Enviar solamente el total'),
            ),
            ElevatedButton(
              onPressed: () => _launchWhatsAppComplete(),
              child: const Text('Enviar el total  + detalles'),
            ),
          ],
        );
        //
      });
}

//////// send only total by user ////////
_launchWhatsAppSimple() async {
  final lista = Singleton().listaUsuarios;
  String textToWhatsapp = '';

  // get total by user
  lista.map((e) {
    return textToWhatsapp += '-----------\nPagar ${e.userNombre.toUpperCase()}: \$${e.totalAPagar}\n';
  }).toString();

  print(textToWhatsapp);

  final link = WhatsAppUnilink(
    phoneNumber: '',
    text: textToWhatsapp,
  );

  await launch('$link');
}

//////// send details of each service to pay by user ////////
_launchWhatsAppComplete() async {
  final lista = Singleton().listaUsuarios;
  String textToWhatsapp = '';

  // get total by user
  for (var user in lista) {
    String servicesDatils = '';

    // get services by user
    for (var servicio in user.servicios) {
      servicesDatils += '${servicio.servicio.servicioNombre} ${servicio.aPagar}\n';
    }

    String total = '-----------\nPagar ${user.userNombre.toUpperCase()}: \$${user.totalAPagar}\n$servicesDatils';
    textToWhatsapp += total;
  }

  print(textToWhatsapp);

  final link = WhatsAppUnilink(
    phoneNumber: '',
    text: textToWhatsapp,
  );

  await launch('$link');
}
