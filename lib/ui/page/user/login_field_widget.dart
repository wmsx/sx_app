import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  LoginTextField({
    this.label,
    this.icon,
    this.controller,
    this.obscureText: false,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  _LoginTextFieldState createState() {
    return _LoginTextFieldState();
  }
}

class _LoginTextFieldState extends State<LoginTextField> {
  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier,
        builder: (context, value, child) => TextFormField(
          controller: this.controller,
          obscureText: value,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: theme.accentColor, size: 22),
            hintText: widget.label,
            hintStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
