import 'package:flutter/material.dart';

class MyButton1 extends StatelessWidget {
  const MyButton1({Key? key, required this.onTap, required this.label})
      : super(key: key);
  final Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.zero,
          ),
          width: double.infinity,
          height: 54,
          child: Center(
              child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white, fontSize: 26),
          )),
        ));
  }
}

class MyButton2 extends StatelessWidget {
  const MyButton2({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
