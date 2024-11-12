import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/conversation.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5001';

  Future<List<Conversation>> getConversations() async {
    final response = await http.get(Uri.parse('$baseUrl/conversations'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Conversation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<String> createConversation(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );
    return response.body;
  }

  Future<String> chat(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );
    return response.body;
  }

}
