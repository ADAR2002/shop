import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  const ConditionalBuilder(
      {Key? key,
      required this.conditional,
      required this.builder,
      required this.fallback})
      : super(key: key);
  final bool conditional;
  final Widget Function(BuildContext context) builder;
  final Widget Function(BuildContext context) fallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: conditional ? builder(context) : fallback(context),
    );
  }
}
