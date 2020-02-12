import 'package:flutter/material.dart';

class CommonFunc{
  get pushPage=>_pushPage;
    void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}