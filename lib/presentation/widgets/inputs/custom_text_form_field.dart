import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? errorMessage;
  final IconData? prefixIcon;
  final Widget? prefix;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.suffix,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: BorderSide(color: colors.surfaceVariant),
        // borderSide: const BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(20));

    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
      elevation: 0,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        enabled: enabled,
        readOnly: readOnly,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          prefix: prefix,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: colors.primary)
              : null,
          // floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          errorBorder:
              border.copyWith(borderSide: BorderSide(color: colors.error)),
          focusedErrorBorder:
              border.copyWith(borderSide: BorderSide(color: colors.error)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          suffix: suffix,
          suffixIcon: suffixIcon,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
