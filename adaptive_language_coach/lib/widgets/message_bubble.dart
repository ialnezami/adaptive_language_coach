import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isUserMessage;

  MessageBubble({required this.message, required this.sender, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isUserMessage ? Colors.blueAccent : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sender, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Text(message, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
