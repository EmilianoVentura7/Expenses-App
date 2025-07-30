import 'package:flutter/material.dart';

class RegisterPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const RegisterPasswordField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Ingresa tu contraseña',
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
      obscureText: true,
      validator: validator,
    );
  }
}
