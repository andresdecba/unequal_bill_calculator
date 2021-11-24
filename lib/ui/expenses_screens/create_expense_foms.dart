import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class CreateExpenseForms extends StatefulWidget {
  const CreateExpenseForms({required this.onEdit, this.expense, Key? key}) : super(key: key);

  final bool onEdit;
  final ExpenseModel? expense;

  @override
  _CreateExpenseFormsState createState() => _CreateExpenseFormsState();
}

class _CreateExpenseFormsState extends State<CreateExpenseForms> {
  // textfield controllers
  var _nameController = TextEditingController();
  var _priceController = TextEditingController();
  late FocusNode _focusNode_1;
  late FocusNode _focusNode_2;

  String _newName = '';
  String _monto = '0.0';

  @override
  void initState() {
    super.initState();

    // below lines makes it work 'the clear text suffix icon'
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));

    // below lines add initial value on text the fields
    _nameController = TextEditingController(text: widget.onEdit == false ? '' : widget.expense!.expenseName);
    _priceController = TextEditingController(text: widget.onEdit == false ? '' : widget.expense!.expensePrice.toString());

    _focusNode_1 = FocusNode();
    _focusNode_2 = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesScreenState>(context);

    return Column(
      children: [
        ////////// NAME TEXT FIELD //////////
        Form(
          key: widget.onEdit == false ? _state.cuentasFormKey : _state.editCuentasFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                focusNode: _focusNode_1,
                decoration: inputDecoration(controller: _nameController, hintText: 'Nombre servicio'),
                onChanged: (value) => setState(() => _newName = value),
                onFieldSubmitted: (value) {
                  setState(() => _newName = value);
                  FocusScope.of(context).requestFocus(_focusNode_2);
                },
                validator: (value) => (value!.isEmpty) ? 'ingrese un titulo' : null,
              ),
              kSizedBoxSmall,

              ////////// PRICE TEXT FIELD //////////
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                focusNode: _focusNode_2,
                decoration: inputDecoration(controller: _priceController, hintText: 'Precio servicio'),
                onChanged: (value) => setState(() => _monto = value), //double.parse(value),
                onFieldSubmitted: (value) => setState(() => _monto = value), //double.parse(value),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                validator: (value) => (value!.isEmpty) ? 'ingrese un monto' : null,
              ),
            ],
          ),
        ),
        kSizedBoxSmall,

        widget.onEdit == false

            ////////// *CREATE* EXPENSE BUTTON //////////
            ? ElevatedButton(
                style: buttonDecoration(),
                child: const Text('> agregar'),
                onPressed: () {
                  // SEARCH IF ITEM ALREADY EXISTS
                  bool itemExist = false;
                  _state.expensesBox.values.map((e) {
                    if (e.expenseName == _newName) {
                      itemExist = true;
                    }
                  }).toString();

                  // VALIDATE ITEM NAME AND FORMS
                  if (_state.validateCuentasFormKey() == true && itemExist == false) {
                    ////// create service
                    _state.crearServicio(servicioNombre: _newName, precioServ: double.parse(_monto));
                    _priceController.clear();
                    _nameController.clear();
                    _focusNode_1.requestFocus();
                  } else if (itemExist == true) {
                    ///// expense already exists snackBar alert
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarCustom(message: 'El gasto ya existe, utilice un nombre diferente.'),
                    );
                  } else {
                    ///// no expenses added snackBar alert
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarCustom(message: 'Defina un nombre y un precio'),
                    );
                  }
                },
              )

            ////////// *EDIT* EXPENSE BUTTON //////////
            : ElevatedButton(
                style: buttonDecoration(),
                child: const Text('> OK'),
                onPressed: () {
                  // SEARCH IF ITEM ALREADY EXISTS
                  bool itemExist = false;
                  _state.expensesBox.values.map((item) {
                    if (item.expenseName == _newName && item.expenseName != widget.expense!.expenseName) {
                      itemExist = true;
                    }
                  }).toString();

                  if (_state.validateEditCuentasFormKey() == true && itemExist == false) {
                    ///// edit service
                    _state.editarServicio(expense: widget.expense!, serviceName: _newName, servicePrice: double.parse(_monto));
                    _priceController.clear();
                    _nameController.clear();
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  } else if (itemExist == true) {
                    ///// expense already exists snackBar alert
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarCustom(message: 'El gasto ya existe, utilice un nombre diferente.'),
                    );
                  }
                },
              ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _focusNode_1.dispose();
    _focusNode_2.dispose();
    super.dispose();
  }
}
