import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateExpenseForms extends StatefulWidget {
  const CreateExpenseForms({required this.onEdit, this.serviceIndex, Key? key}) : super(key: key);

  final bool onEdit;
  final int? serviceIndex;

  @override
  _CreateExpenseFormsState createState() => _CreateExpenseFormsState();
}

class _CreateExpenseFormsState extends State<CreateExpenseForms> {
  var _nameController = TextEditingController();
  var _priceController = TextEditingController();

  String _nombre = '';
  String _monto = '0.0';

  @override
  void initState() {
    super.initState();

    // below lines makes it work 'the clear text suffix icon'
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));

    // below lines add initial value on text the fields
    _nameController = TextEditingController(text: widget.onEdit == false ? '' : CalculateState().listaServicios[widget.serviceIndex!].servicioNombre);
    _priceController = TextEditingController(text: widget.onEdit == false ? '' : CalculateState().listaServicios[widget.serviceIndex!].precio.toString());
  }

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesState>(context);

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
                textInputAction: TextInputAction.done,
                decoration: inputDecoration(controller: _nameController, hintText: 'Nombre servicio'),
                onChanged: (value) => setState(() => _nombre = value),
                onFieldSubmitted: (value) => setState(() => _nombre = value),
                validator: (value) {
                  return (value!.isEmpty) ? 'ingrese un titulo' : null;
                },
              ),
              const SizedBox(height: 15),

              ////////// PRICE TEXT FIELD //////////
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                decoration: inputDecoration(controller: _priceController, hintText: 'Precio servicio'),
                onChanged: (value) => setState(() => _monto = value), //double.parse(value),
                onFieldSubmitted: (value) => setState(() => _monto = value), //double.parse(value),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                validator: (value) {
                  return (value!.isEmpty) ? 'ingrese un monto' : null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        widget.onEdit == false

            ////////// *CREATE* EXPENSE BUTTON //////////
            ? ElevatedButton(
                style: buttonDecoration(),
                child: const Text('> agregar'),
                onPressed: () {
                  // SEARCH IF ITEM ALREADY EXISTS
                  bool itemExist = false;
                  _state.listaServicios.map((e) {
                    if (e.servicioNombre == _nombre) {
                      itemExist = true;
                    }
                  }).toString();

                  if (_state.validateCuentasFormKey() == true && itemExist == false) {
                    ////// create service
                    _state.crearServicio(servicioNombre: _nombre, precioServ: double.parse(_monto));
                    _priceController.clear();
                    _nameController.clear();
                    FocusScope.of(context).unfocus();
                  } else if (itemExist == true) {
                    ///// expense already exists snackBar alert
                    const snb = SnackBar(
                      content: Text('El servicio ya existe, utilice un nombre diferente.'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snb);
                  } else {
                    ///// empty fields snackBar alert
                    const snb = SnackBar(
                      content: Text('Defina un nombre y un precio'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snb);
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
                  _state.listaServicios.map((item) {
                    if (item.servicioNombre == _nombre && item.servicioNombre != _state.listaServicios[widget.serviceIndex!].servicioNombre) {
                      itemExist = true;
                    }
                  }).toString();

                  if (_state.validateEditCuentasFormKey() == true && itemExist == false) {
                    ///// edit service
                    _state.editarServicio(index: widget.serviceIndex!, serviceName: _nombre, servicePrice: double.parse(_monto));
                    _priceController.clear();
                    _nameController.clear();
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  } else if (itemExist == true) {
                    ///// alert snackBar
                    const snb = SnackBar(
                      content: Text('El servicio ya existe, utilice un nombre diferente.'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snb);
                  }
                },
              ),
      ],
    );
  }
}
