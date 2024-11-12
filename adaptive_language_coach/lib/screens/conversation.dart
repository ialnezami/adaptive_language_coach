import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/conversation.dart';
import 'CreateConversation.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}
class _ConversationScreenState extends State<ConversationScreen> {
  late Conversation activeConversation;

  @override
  void initState() {
    super.initState();
    activeConversation = Conversation(
      id: 'initial_id',
      messages: [],
      title: 'Conversation',
      timestamp: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conversations')),
      body: Column(
        children: [
          Text('Message: ${activeConversation.title}'),
          Text('Timestamp: ${activeConversation.timestamp}'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Navigate to CreateConversationScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateConversationScreen()),
    );
  },
  child: Icon(Icons.add),
),
    );
  }
}








