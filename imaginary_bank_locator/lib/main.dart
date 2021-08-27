import 'package:flutter/material.dart';

void main() {
  runApp(ImaginaryBankLocator());
}

class ImaginaryBankLocator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imaginary Bank Locator',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      
    );
  }
}

