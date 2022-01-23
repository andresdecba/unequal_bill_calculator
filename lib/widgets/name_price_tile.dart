import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameAndPriceTile extends StatelessWidget {
  const NameAndPriceTile({
    this.title,
    this.subTitle,
    this.deleteFnc,
    this.editFnc,
    Key key,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final VoidCallback deleteFnc;
  final Widget editFnc;

  @override
  Widget build(BuildContext context) {
    //final _sizeScreen = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          //Anacolor: Colors.green[100],
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              subTitle == null
                  ?

                  ///// OPT 1: ONLY TITLE /////
                  Flexible(
                      child: Text(
                        title,
                        style: kTextSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )

                  ////// OPT 2: TITLE + SUBTITLE /////
                  : Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: kTextSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // text 2
                          Text(
                            subTitle,
                            style: kTextSmall,
                          ),
                        ],
                      ),
                    ),

              ///// BUTTONS EDIT - DELETE /////
              kSizedBoxBig,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // show dialog box
                  kIconButton(
                    icon: Icons.edit,
                    onPress: () => showDialog(
                      barrierColor: kDialogBackground,
                      context: context,
                      builder: (context) => DialogBox(
                        title: 'Editar usuario',
                        children: Column(
                          children: [
                            editFnc,
                            const CancelButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kSizedBoxBig,
                  // delete user
                  kIconButton(
                    icon: Icons.delete_forever,
                    onPress: deleteFnc, //
                  ),
                ],
              )
            ],
          ),
        ),
        kDivider
      ],
    );
  }
}
