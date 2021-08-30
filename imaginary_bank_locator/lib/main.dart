import 'package:flutter/material.dart';
import 'package:imaginary_bank_locator/routes.dart';
import 'package:imaginary_bank_locator/tab_navigation.dart';
import 'package:provider/provider.dart';

import 'dependency_injection.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ...repositoryProviders,
      ...stateNotifierProviders,
    ], child: ImaginaryBankLocator()),
  );
}

class ImaginaryBankLocator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imaginary Bank Locator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        
        
      ),
      routes: routes,
      home: TabNavigation(),
    );
  }
}
