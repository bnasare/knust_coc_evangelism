import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

class RegisterProspectPage extends StatefulWidget {
  const RegisterProspectPage({super.key});

  @override
  State<RegisterProspectPage> createState() => _RegisterProspectPageState();
}

class _RegisterProspectPageState extends State<RegisterProspectPage> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Prospect'),
        ),
      ),
    );
  }
}
