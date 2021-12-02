import 'package:flutter/material.dart';

import 'package:launch_review/launch_review.dart';

import 'package:bill_calculator/styles/colors.dart';
import 'package:bill_calculator/styles/spacing.dart';
import 'package:bill_calculator/styles/texts.dart';

class AboutTheApp extends StatelessWidget {
  const AboutTheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenData = MediaQuery.of(context).size;
    const String _playStoreUrl = 'com.calculadora.desigual';

    return Scaffold(
      backgroundColor: kAmarillo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAmarillo,
        iconTheme: const IconThemeData(color: kNegro),
      ),
      body: Container(
        padding: kPaddingMedium,
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: _screenData.width * 0.45,
              child: Image.asset('assets/images/app_logo_black.png'),
            ),
            const Text('> Versión: 1.0.0', style: kTextSmall),
            kDivider,
            ListTile(
              title: const Text('Compartir APP', style: kTextMedium),
              trailing: const Icon(Icons.arrow_forward_ios),
              dense: true,
              onTap: () {},
            ),
            kDivider,
            ListTile(
              title: const Text('Calificar en playstore', style: kTextMedium),
              trailing: const Icon(Icons.arrow_forward_ios),
              dense: true,
              onTap: () async => LaunchReview.launch(
                androidAppId: _playStoreUrl,
              ),
            ),
            kDivider,
          ],
        ),
      ),
    );
  }
}
