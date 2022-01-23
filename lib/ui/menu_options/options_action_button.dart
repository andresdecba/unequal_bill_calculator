import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/ui/menu_options/menu_options.dart';
import 'package:bill_calculator/styles/styles.dart';


class OptionsActionButton extends StatelessWidget {
  const OptionsActionButton({this.activeTab, Key key}) : super(key: key);

  final bool activeTab;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      elevation: 10,
      overlayOpacity: 0.5,
      overlayColor: Colors.black, // color de fondo en la pantalla
      spacing: 20,
      children: [
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.info),
          label: 'Acerca de esta APP',
          labelStyle: kTextSmall,
          onTap: () {
            Navigator.push(
              // or pushReplacement, if you need that
              context,
              FadeInRoute(
                routeName: "/agregarCuentas",
                page: const AboutTheApp(),
              ),
            );

            //Navigator.pushNamed(context, '/aboutTheApp')
          },
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.local_fire_department_outlined),
          label: 'Crear una cuenta nueva',
          labelStyle: kTextSmall,
          onTap: () => deleteAndCreateNewBill(context),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.group),
          label: 'Ver lista de usuarios',
          labelStyle: kTextSmall,
          onTap: () => Navigator.of(context).popUntil(ModalRoute.withName("/createUsers")),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.list),
          label: 'Ver lista de gastos',
          labelStyle: kTextSmall,
          onTap: () => Navigator.of(context).popUntil(ModalRoute.withName("/agregarCuentas")),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.replay),
          label: 'Resetear divisores',
          labelStyle: kTextSmall,
          onTap: () => resetValues(context),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.label),
          label: 'Cambiar el título',
          labelStyle: kTextSmall,
          onTap: () => changeBillTitle(context),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.7),
          child: const Icon(Icons.whatsapp),
          label: 'Enviar por WhatsApp',
          labelStyle: kTextSmall,
          onTap: () => whatsappLauncher(context, activeTab),
        ),
      ],
    );
  }
}
