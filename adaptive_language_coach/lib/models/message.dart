class Message {
  final String message;
  final String sender;
  final DateTime timestamp;

  Message({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      sender: json['sender'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}