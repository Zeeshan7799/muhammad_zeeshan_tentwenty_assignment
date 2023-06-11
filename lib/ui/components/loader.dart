import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class buildLoader extends StatelessWidget {
  const buildLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? const CircularProgressIndicator() : const CupertinoActivityIndicator();
  }

}
