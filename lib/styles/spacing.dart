import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';

//////////// spacing ///////////

////// generic spaces
const double kSpaceSmall = 20.0;
const double kSpaceMedium = 40.0;
const double kSpaceLarge = 60.0;

////// Paddings
const kPaddingXXS = EdgeInsets.all(10);
const kPaddingXS = EdgeInsets.all(15);
const kPaddingSmall = EdgeInsets.all(20);
const kPaddingMedium = EdgeInsets.all(25);
const kPaddingLarge = EdgeInsets.all(30);

////// Spacers
const kSizedBoxBig = SizedBox(
  height: 10,
  width: 10,
);

const kSizedBoxSmall = SizedBox(
  height: 5,
  width: 5,
);

const kDivder = Divider(
  height: 10,
  thickness: 1,
  //indent: 10,
  //endIndent: 10,
);

const kDivderBlue = Divider(
  height: 0,
  thickness: 1,
  color: kAzul,
  //indent: 10,
  //endIndent: 10,
);

const kFooterSpace = SizedBox(
  height: 80,
);
