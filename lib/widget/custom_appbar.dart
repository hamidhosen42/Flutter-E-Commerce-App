// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
    {String? title,
    List<Widget>? action,
    Widget? isLeading,
    required BuildContext context,
    Color? backgroundColor}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: isLeading ??
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
    title: title != null ? Text(title) : null,
    actions:action,
  );
}
