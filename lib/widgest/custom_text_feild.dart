import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final FormFieldValidator<String>? validator; // Add validator as a parameter

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator, // Optional validator in constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator, // Use the passed validator
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
