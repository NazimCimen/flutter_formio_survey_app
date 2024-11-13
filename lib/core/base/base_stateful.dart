import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseStateful<T extends StatefulWidget, VM> extends State<T> {
  final VM? viewModel;

  BaseStateful({this.viewModel});

  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
  ThemeData get themeData => Theme.of(context);

  VM get readViewModel => context.read<VM>();
  VM get watchViewModel => context.watch<VM>();
}
