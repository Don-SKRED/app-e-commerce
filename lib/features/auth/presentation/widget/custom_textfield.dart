import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final bool isFieldPassword;
  final bool showPassword;
  final String hintTextValue;
  final void Function()? onPressedFunction;
  final FontWeight fontWeight;
  final double radius;
  final String labelText;
  final double spacing;
  final String? Function(String? value)? validatorFunction;
  final void Function(String? value)? onSavedFunction;
  final TextEditingController? controller;
  const CustomTextfield({
    super.key,
    this.isFieldPassword = false,
    this.showPassword = false,
    required this.hintTextValue,
    this.onPressedFunction,
    required this.fontWeight,
    required this.radius,
    required this.labelText,
    required this.spacing,
    this.validatorFunction,
    this.onSavedFunction,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        Text(labelText),
        TextFormField(
          controller: controller,
          validator: validatorFunction,
          onSaved: onSavedFunction,
          obscureText: isFieldPassword ? showPassword : false,
          decoration: InputDecoration(
            hintText: hintTextValue,
            suffixIcon: (!isFieldPassword)
                ? null
                : IconButton(
                    onPressed: onPressedFunction,
                    icon: (showPassword)
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
            hintStyle: TextStyle(fontWeight: fontWeight),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ],
    );
  }
}
