import 'package:flutter/material.dart';

class KeysToBeInherited extends InheritedWidget {
  final GlobalKey cartIndicatorKey;
  final GlobalKey categoriesKey;
  final GlobalKey optionsKey;
  final GlobalKey searchKey;
  final GlobalKey nameKey;

  KeysToBeInherited({
    this.cartIndicatorKey,
    this.categoriesKey,
    this.optionsKey,
    this.searchKey,
    this.nameKey,
    Widget child
  }) : super(child: child);

  static KeysToBeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KeysToBeInherited>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}