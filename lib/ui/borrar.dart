import 'package:flutter/material.dart';

class Borrar extends StatefulWidget {
  Borrar({Key? key}) : super(key: key);

  @override
  _BorrarState createState() => _BorrarState();
}

class _BorrarState extends State<Borrar> {
  List listaa = ['aaa', 'bbb', 'ccc'];
  List<bool> _isOpen = [true, true];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: ExpansionPanelList(
            expandedHeaderPadding: const EdgeInsets.all(10),
            expansionCallback: (int index, bool isOpen) {
              setState(() {
                _isOpen[index] = !isOpen;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, isOpen) {
                  return const Text('AAA');
                },
                body: const Text('open now'),
                isExpanded: _isOpen[0],
              ),
              ExpansionPanel(
                headerBuilder: (context, isOpen) {
                  return Text('BBB');
                },
                body: Text('open now'),
                isExpanded: _isOpen[1],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
