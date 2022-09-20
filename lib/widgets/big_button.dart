import "package:flutter/material.dart";

class BigButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const BigButton(this.title, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: () => onTap(context),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
        ),
        child: Text(title, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}
