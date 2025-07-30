import 'package:flutter/material.dart';

class RegisterEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const RegisterEmailField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'example@gmail.com',
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
    );
  }
}
