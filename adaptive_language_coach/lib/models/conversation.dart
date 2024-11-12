import 'message.dart';

class Conversation {
  final String id;
  final List<Message> messages;
  final DateTime timestamp;
  final String title = 'Conversation';

  Conversation({
    required this.id,
    required this.messages,
    required this.timestamp,
    title = 'Conversation',
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      messages: (json['messages'] as List)
          .map((msg) => Message.fromJson(msg))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}