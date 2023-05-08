import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;

  final String formProperty;
  final Map<String, String> formValues;

  const CustomInputField({
    super.key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.isPassword = false,
    required this.formProperty,
    required this.formValues,
  });

  @override
  Widget build(BuildContext context) {
    final InputDecorationTheme theme = AppTheme.lightTheme.inputDecorationTheme;

    return TextFormField(
      style: TextStyle(color: Colors.black, backgroundColor: Colors.white),
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onChanged: (value) {
        formValues[formProperty] = value;
      },
      validator: (value) {
        if (value == null) return 'Este campo es requerido';
        return value.length < 3 ? 'Mínimo de 3 letras' : null;
      },
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
        border: theme.border,
        focusedBorder: theme.focusedBorder,
        enabledBorder: theme.enabledBorder,
        floatingLabelStyle: theme.floatingLabelStyle,
        fillColor: theme.fillColor,
      ),
    );
  }
}
