
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final bool isNumber;
  final bool? isObscure;
  final void Function()? onTapIcon;

  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.label,
    required this.icon,
    required this.controller,
    this.valid,
    required this.isNumber,
    this.isObscure,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: valid,
      obscureText: isObscure ?? false,
      controller: controller,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor:Theme.of(context).colorScheme.surface, //theme.cardColor,
        hintText: hintText,
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
        labelText: label,
        labelStyle: theme.textTheme.bodySmall?.copyWith(
          color: Colors.grey.shade700,
          fontSize: 14,
        ),
        suffixIcon: InkWell(
          onTap: onTapIcon,
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

