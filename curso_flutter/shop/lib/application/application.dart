import 'package:flutter/material.dart';

abstract class Application {
  static final navKey = GlobalKey<NavigatorState>();
  static final managerProductsScaffold = GlobalKey<ScaffoldState>();
  static String productsUrl;
}