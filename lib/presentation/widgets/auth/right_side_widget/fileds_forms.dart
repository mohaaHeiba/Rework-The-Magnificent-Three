import 'package:flutter/material.dart';

Widget fieldsTextForm(
  String title,
  String hint,
  IconData icon,
  bool obscure,
  BuildContext context,
  TextEditingController controll,
) {
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: theme.textTheme.titleMedium),
      const SizedBox(height: 6),
      TextFormField(
        controller: controll,
        obscureText: obscure,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: theme.colorScheme.primary),
          hintText: hint,
          filled: true,
          fillColor: theme.colorScheme.surface.withOpacity(.9),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 1.4,
            ),
          ),
        ),
      ),
    ],
  );
}
