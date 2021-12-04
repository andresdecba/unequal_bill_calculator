import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class CreateUsersForm extends StatefulWidget {
  const CreateUsersForm({required this.onEdit, this.user, Key? key}) : super(key: key);

  // flag: creating or editing a user?
  final bool onEdit;
  final UserModel? user;

  @override
  _CreateUsersFormState createState() => _CreateUsersFormState();
}

class _CreateUsersFormState extends State<CreateUsersForm> {
  String _nombre = '';
  var _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // below line makes it work clear text suffix icon
    _textController.addListener(() => setState(() {}));

    // below line adds initial value on text field
    _textController = TextEditingController(text: widget.onEdit == false ? '' : widget.user!.userName);
  }

  @override
  Widget build(BuildContext context) {
    ////////// PROVIDER //////////
    final _state = Provider.of<CreateUsersScreenState>(context);

    return Column(
      children: [
        ////////// NAME TEXT FIELD //////////
        Form(
          key: widget.onEdit == false ? _state.createUserFormKey : _state.editUserFormKey,
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
          child: Text(
            widget.onEdit == true ? '> ok' : '> agregar',
            style: kButtonsText,
          ),
          onPressed: () async {
            // LOOK IF THE entered item name already exists
            bool itemExist = false;
            _state.usersBox.values.map((e) {
              if (e.userName == _nombre) {
                itemExist = true;
              }
            }).toString();

            // VALIDATE ITEM's NAMES AND FORMS
            // if create
            if (widget.onEdit == false && _state.validateCreateUserFormKey() == true && itemExist == false) {
              // create user
              await _state.crearUsuario(usrName: _nombre);
              // clear text field
              _textController.clear();
              //FocusScope.of(context).unfocus();
            }
            // if update
            else if (widget.onEdit == true && _state.validateEditUserFormKey() == true && itemExist == false) {
              _state.updateUser(newName: _nombre, user: widget.user!);
              _textController.clear();
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            }
            // else show advise
            else {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarCustom(message: 'Ese nombre ya existe, utilice uno diferente.'),
              );
            }
          },
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


//FocusScope.of(context).unfocus();