import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 30,
          width: 5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)), // <= No more error here :)
              color: Theme.of(context).colorScheme.primary,
        )),
        const SizedBox(
          width: 4,
        ),
        Text(label, style: Theme.of(context).textTheme.titleLarge)
      ],
    );
  }
}
