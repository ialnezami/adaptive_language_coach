import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/conversation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Language Coach',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/conversation': (context) => ConversationScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
