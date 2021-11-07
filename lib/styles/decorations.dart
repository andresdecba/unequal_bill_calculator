import 'package:flutter/material.dart';

InputDecoration inputDecoration({required TextEditingController controller, required String hintText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),

    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    suffixIcon: controller.text.isEmpty
        ? Container(
            width: 0,
          )
        : IconButton(
            onPressed: () => controller.clear(),
            icon: const Icon(Icons.clear),
          ),
    //labelText: title,
    hintText: hintText,
    hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[400]),
    alignLabelWithHint: true,
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFd3a007)),
    ),
    fillColor: Colors.white,
    filled: true,
  );
}

ButtonStyle buttonDecoration({double widthCustom = double.infinity}) {
  return ElevatedButton.styleFrom(
    
    primary: Colors.black,
    minimumSize: Size(widthCustom, 35),
    textStyle: const TextStyle(fontSize: 20, fontFamily: 'Highman'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 0,
  );
}


BoxDecoration containerDecoration() {
  return const BoxDecoration(
    color: Colors.amber,
  );
}
