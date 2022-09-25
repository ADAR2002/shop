import 'package:flutter/material.dart';
import 'package:shop/business_logic/dark_cubit/dark_cubit.dart';

class MyTextFailed extends StatelessWidget {
  const MyTextFailed({
    Key? key,
    this.prefix,
    this.suffix,
    required this.label,
    required this.controller,
    required this.validator,
    required this.isPassword,
  }) : super(key: key);
  final bool isPassword;
  final Widget? prefix;
  final Widget? suffix;
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        style:  Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          label: Text(
            label,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          labelStyle: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
