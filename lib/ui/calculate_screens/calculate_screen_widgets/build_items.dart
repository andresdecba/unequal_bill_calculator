import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class BuildItems extends StatelessWidget {
  //
  const BuildItems({Key? key, required this.user, required this.indexxxx}) : super(key: key);
  final UserModel user;
  final int indexxxx;

  @override
  Widget build(BuildContext context) {
    //
    final _state = Provider.of<CalculateScreenState>(context);

    return Column(
      children: [
        // upper divider
        kDivderBlue,
        ListView.separated(
          itemCount: user.userExpensesList.length,
          separatorBuilder: (context, index) => kDivderBlue,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            //
            var expense = user.userExpensesList.elementAt(index);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: kGris300, //Colors.grey[50], //user.userExpensesList.elementAt(index).userExpenseByItemFactor > 1 ? Colors.grey[200] : Colors.grey[50],
              child: Column(
                children: [
                  kSizedBoxBig,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /////////// EXPENSE NAME /////////
                      Flexible(
                        child: Text(
                          expense.userExpenseExpense.first.expenseName,
                          style: kTextSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ////////// EXPENSE PRICE ///////
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            ':  \$ ${user.userExpensesList.elementAt(index).userExpenseExpense.first.expensePrice}',
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
                        expense.userExpenseByItemFactor > 1 ? '>  \$ ${expense.userExpenseTotal}' : '\$ ${expense.userExpenseTotal}',
                        style: kTextMedium,
                      ),
                      //////// BUTTONS +- /////////
                      SubstractAddButtons(
                        isLoading: _state.isLoading,
                        sunstractBttn: () => _state.restarItem(userExpense: user.userExpensesList.elementAt(index)),
                        quantity: expense.userExpenseByItemFactor.toString(),
                        addBttn: () => _state.sumarItem(userExpense: _state.usersBox.values.elementAt(indexxxx).userExpensesList.elementAt(index)),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
        kDivderBlue,
      ],
    );
  }
}
