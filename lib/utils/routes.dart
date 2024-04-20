import 'package:flutter/material.dart';
import 'package:quotes_app/views/home_screen.dart';
import 'package:quotes_app/views/quote_details_screen.dart';

class Routes {
  Routes._();
  static Routes instance = Routes._();

  String homeScreen = '/', detailScreen = 'detailScreen';

  static Map<String, WidgetBuilder> screens = {
    '/': (context) => const HomeScreen(),
    'detailScreen': (context) => const QuoteDetailsScreen(),
  };
}
