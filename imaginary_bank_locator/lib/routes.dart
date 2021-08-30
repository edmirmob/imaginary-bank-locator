import 'package:flutter/material.dart';
import 'package:imaginary_bank_locator/shared/dialog_view.dart';
import 'package:imaginary_bank_locator/ui/viewDetails/view_details_screen.dart';
import 'package:imaginary_bank_locator/ui/viewList/view_list_screen.dart';
import 'package:imaginary_bank_locator/tab_navigation.dart';

Map<String, WidgetBuilder> routes = {
  TabNavigation.route: (_) => TabNavigation(),
  ViewListScreen.route:(_)=>ViewListScreen(),
  ViewDetailsScreen.route:(_)=>ViewDetailsScreen(),
  DialogView.route:(_)=>DialogView()
};