import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/Strings_Manger.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppString.settings),
    );
  }
}
