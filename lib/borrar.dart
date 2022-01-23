import 'package:flutter/material.dart';

class Borrar extends StatefulWidget {
  const Borrar({Key key}) : super(key: key);

  @override
  State<Borrar> createState() => _BorrarState();
}

class _BorrarState extends State<Borrar> {
  final List<String> _items = ['item 1', 'item 2', 'item 3', 'item 4'];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(),
      ),
      body: SafeArea(
        child: AnimatedList(
          key: _key,
          initialItemCount: _items.length,
          itemBuilder: (context, index, animation) {
            return _builItem(item: _items[index], animation: animation, index: index);
          },
        ),
      ),
    );
  }

  _builItem({String item, Animation<double> animation, int index}) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(item),
        trailing: IconButton(
          onPressed: () => _removeItem(index),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }

  void _removeItem(index) {
    String removedItem = _items.removeAt(index);

    _key.currentState.removeItem(index, (context, animation) {
      return _builItem(item: removedItem, animation: animation, index: index);
    });
  }

  void _addItem() {
    int i = _items.isEmpty ? _items.length : 0;
    _items.insert(i, 'Item ${_items.length + 1}');
    _key.currentState.insertItem(i);
  }
}
