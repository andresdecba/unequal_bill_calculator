import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserTotalTile extends StatelessWidget {
  const UserTotalTile({
    Key key,
    this.user,
    this.anyWidget,
    CalculateScreenState state,
  })  : _state = state,
        super(key: key);

  final UserModel user;
  final CalculateScreenState _state;
  final Widget anyWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: user.userByGlobalFactor > 1 ? kGris300 : Colors.grey[50],
          width: double.infinity,
          padding: kPaddingSmall, //const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              //////////// USERNAME AND TOTAL //////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    // user name
                    child: Text(
                      '> ${user.userName}',
                      style: kTextLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 40),

                  // show progress indicator wile is calculating
                  _state.isLoading
                      ? const ProgressIndicartor()
                      : Row(
                          children: [
                            // price
                            Text(
                              '\$  ${user.userTotalByGlobal.toString()}',
                              style: kTextLarge,
                            ),
                            kSizedBoxBig,
                          ],
                        ),
                ],
              ),

              anyWidget ?? const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
