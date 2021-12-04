import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class PropinaDialogBox extends StatefulWidget {
  const PropinaDialogBox({Key? key}) : super(key: key);
  @override
  State<PropinaDialogBox> createState() => _PropinaDialogBoxState();
}

class _PropinaDialogBoxState extends State<PropinaDialogBox> {
  final _propinaTextController = TextEditingController();
  bool _togleCheckBox = true;

  @override
  void initState() {
    super.initState();
    // below line makes it work clear text suffix icon
    _propinaTextController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<Propina>(context);

    return SimpleDialog(
      backgroundColor: Colors.amber,
      contentPadding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      title: const Text(
        "Editar propina",
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      children: [
        ////////// PORCENTAJE //////////
        CheckboxListTile(
          contentPadding: const EdgeInsets.all(0),
          value: _togleCheckBox,
          title: const Text('Porcentaje', style: TextStyle(fontSize: 24)),
          onChanged: (value) => setState(() {
            _togleCheckBox = value!;
          }),
        ),
        Opacity(
          opacity: _togleCheckBox ? 1.0 : 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(right: 20),
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () async => _state.restarPorcentaje(),
                  ),
                  Text('${_state.propinaPercent.toString()} %'),
                  IconButton(
                    padding: const EdgeInsets.only(left: 20),
                    icon: const Icon(Icons.add_circle),
                    onPressed: () async => _state.sumarPorcentaje(),
                  ),
                ],
              ),
              Text(
                ('\$ ${_state.propinaFromPercent.toString()}'),
                style: const TextStyle(fontSize: 26),
              ),
            ],
          ),
        ),
        const Divider(),

        ////////// MONTO FIJO //////////
        CheckboxListTile(
          contentPadding: const EdgeInsets.all(0),
          value: !_togleCheckBox,
          title: const Text('Monto fijo', style: TextStyle(fontSize: 24)),
          onChanged: (value) => setState(() {
            _togleCheckBox = !value!;
          }),
        ),
        Opacity(
          opacity: !_togleCheckBox ? 1.0 : 0.3,
          child: Form(
            key: _state.propinaFormKey,
            child: TextFormField(
              enabled: !_togleCheckBox,
              controller: _propinaTextController,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: inputDecoration(controller: _propinaTextController, hintText: 'Ingrese un valor'),
              onChanged: (value) => setState(() => _state.propinaFromManual = double.parse(value)), //double.parse(value),
              onFieldSubmitted: (value) => setState(() => _state.propinaFromManual = double.parse(value)), //double.parse(value),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un monto' : null;
              },
            ),
          ),
        ),
        const Divider(),

        ////////// BOTONES //////////
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // cancel button
            ElevatedButton(
              style: buttonDecoration(widthCustom: 100),
              child: const Text('CANCELAR'),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 20),

            // save button
            ElevatedButton(
              style: buttonDecoration(widthCustom: 100),
              child: const Text('OK'),
              onPressed: () async {
                _state.asignarPropina(_togleCheckBox);
                Navigator.pop(context);
              },
            )
          ],
        )
      ],
    );
  }
}
