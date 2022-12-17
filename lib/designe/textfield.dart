import 'package:flutter/material.dart';

class all_textfields {
  static TextFormField textfield(
    final String fieldText, {
    final bool isEnabled,
    final Widget suffixicon,
    final Widget prefexicon,
    final String label,
    final TextEditingController fieldController,
    final ValueSetter onchange,
    final VoidCallback ontap_callback,
    final bool isreadOnly,
    final Function(String) validator
  }) {
    return TextFormField(
      validator: validator,
      onTap: ontap_callback,
      controller: fieldController,
      enabled: isEnabled ?? true,
      readOnly: isreadOnly ?? false,
      onChanged: onchange == null ? (value) {} : (value) => onchange(value),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: fieldText,
        suffixIcon: suffixicon,
        prefixIcon: prefexicon,
        hintStyle: TextStyle(color: Colors.grey),

        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Color.fromRGBO(198, 57, 93, 1)),
        // ),
        // focusedBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Color.fromRGBO(198, 57, 93, 1)),
        // ),
      ),
      // cursorColor: Color.fromRGBO(198, 57, 93, 1),
    );
  }
}
