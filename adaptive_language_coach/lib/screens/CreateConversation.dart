import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class CreateConversationScreen extends StatefulWidget {
  @override
  _CreateConversationScreenState createState() => _CreateConversationScreenState();
}

class _CreateConversationScreenState extends State<CreateConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ApiService apiService = ApiService();
  List<Conversation> conversationHistory = [];

  void _startConversation() async {
    String userMessage = _messageController.text;
    if (userMessage.isNotEmpty) {
      try {
        // Create and save the user's message
        final userMsg = Message(
          message: userMessage,
          sender: 'User',
          timestamp: DateTime.now(),
        );

        setState(() {
          conversationHistory.add(Conversation(
            id: DateTime.now().toString(),
            messages: [userMsg],
            timestamp: DateTime.now(),
          ));
        });

        // Fetch the system's response
        String responseText = await apiService.createConversation(userMessage);

        // Save the response as a message and add it to the same conversation
        final responseMsg = Message(
          message: responseText,
          sender: 'System',
          timestamp: DateTime.now(),
        );

        setState(() {
          conversationHistory.last.messages.add(responseMsg);
        });

        _messageController.clear();  // Clear the input field
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start conversation')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a message')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Conversation')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,  // Display latest messages at the bottom
              itemCount: conversationHistory.length,
              itemBuilder: (context, index) {
                final conversation = conversationHistory[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: conversation.messages.map((msg) {
                    return ListTile(
                      title: Text(msg.sender, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(msg.message),
                      trailing: Text(msg.timestamp.toLocal().toString(), style: TextStyle(fontSize: 10)),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _startConversation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
