import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class BuildItems extends StatelessWidget {
  //
  const BuildItems({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    //
    final _state = Provider.of<CalculateScreenState>(context);

    return Column(
      children: [
        kDivder,
        ListView.separated(
          itemCount: user.userExpensesList.length,
          separatorBuilder: (context, index) => kDivder,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: user.userExpensesList.elementAt(index).userExpenseByItemFactor > 1 ? Colors.grey[200] : Colors.grey[50],
              child: Column(
                children: [
                  kSizedBoxBig,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /////////// EXPENSE NAME /////////
                      Flexible(
                        child: Text(
                          user.userExpensesList.elementAt(index).userExpenseExpense.expenseName,
                          style: kTextMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ////////// EXPENSE PRICE ///////
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            '\$ ${user.userExpensesList.elementAt(index).userExpenseExpense.expensePrice}',
                            style: kTextSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //////// EXPENSE USER TO PAY ////////
                      Text(
                        '\$ ${user.userExpensesList.elementAt(index).userExpenseTotal}',
                        style: kTextMedium,
                      ),
                      //////// BUTTONS +- /////////
                      SubstractAddButtons(
                        isLoading: _state.isLoading,
                        sunstractBttn: () => _state.restarItem(userExpense: user.userExpensesList[index]),
                        quantity: user.userExpensesList.elementAt(index).userExpenseByItemFactor.toString(),
                        addBttn: () => _state.sumarItem(userExpense: user.userExpensesList[index]),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
        kDivder,
      ],
    );
  }
}
