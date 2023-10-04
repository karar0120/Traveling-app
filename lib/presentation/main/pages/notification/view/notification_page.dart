import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/Strings_Manger.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppString.notification),
    );
  }
}
