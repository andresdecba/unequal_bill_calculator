import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class CreateUsersFormAnButton extends StatefulWidget {
  const CreateUsersFormAnButton({required this.onEdit, this.userIndex, Key? key}) : super(key: key);

  // flag: creating or editing a user?
  final bool onEdit;
  final int? userIndex;

  @override
  _CreateUsersFormAnButtonState createState() => _CreateUsersFormAnButtonState();
}

class _CreateUsersFormAnButtonState extends State<CreateUsersFormAnButton> {
  String _nombre = '';
  var _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // below line makes it work clear text suffix icon
    _textController.addListener(() => setState(() {}));

    // below line adds initial value on text field
    _textController = TextEditingController(text: widget.onEdit == false ? '' : CalculateState().listaUsuarios[widget.userIndex!].userNombre);
  }

  @override
  Widget build(BuildContext context) {
    ////////// PROVIDER //////////
    final _state = Provider.of<CreateUsersState>(context);

    return Column(
      children: [
        ////////// NAME TEXT FIELD //////////
        Form(
          key: widget.onEdit == false ? _state.userFormKey : _state.editUserFormKey,
          child: TextFormField(
            controller: _textController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            decoration: inputDecoration(controller: _textController, hintText: 'Ej.: "Andrés", "Marta y Nacho", "flia. Castillo"'),
            onChanged: (value) => setState(() => _nombre = value),
            onFieldSubmitted: (value) => setState(() => _nombre = value),
            validator: (value) {
              return (value!.isEmpty) ? 'ingrese un usuario' : null;
            },
          ),
        ),

        kSizedBoxBig,

        ////////// ADD USER BUTTON //////////
        ElevatedButton(
          style: buttonDecoration(),
          onPressed: () {
            // LOOK FOR THE ITEM NAME
            bool itemExist = false;
            _state.listaUsuarios.map((e) {
              if (e.userNombre == _nombre) {
                itemExist = true;
              }
            }).toString();

            // VALIDATE ITEM's NAMES AND FORMS
            if (widget.onEdit == false && _state.validateUserFormKey() == true && itemExist == false) {
              _state.crearUsuario(usrName: _nombre);
              _textController.clear();
              FocusScope.of(context).unfocus();
            } else if (widget.onEdit == true && _state.validateEditUserFormKey() == true && itemExist == false) {
              _state.editarUsuario(index: widget.userIndex!, nombre: _nombre);
              _textController.clear();
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            } else {
              // const snb = SnackBar(
              //   content: Text('Ese nombre ya existe, utilice uno diferente.'),
              //   backgroundColor: Colors.green,
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarCustom(message: 'Ese nombre ya existe, utilice uno diferente.'),
              );
            }
          },
          child: Text(
            widget.onEdit == true ? '> ok' : '> agregar',
            style: kButtonsText,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
}