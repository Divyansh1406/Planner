import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function handler;
  AdaptiveButton(this.text,this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        handler();
      },
    )
        : TextButton(
      onPressed: () {
        handler();
      },
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
