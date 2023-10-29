// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
    {String? title,
    List<Widget>? action,
    Widget? isLeading,
    required BuildContext context}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: isLeading ??
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
    title: title != null ? Text(title) : null,
    actions: action != null
        ? [IconButton(onPressed: () {}, icon: const Icon(Icons.search))]
        : null,
  );
}