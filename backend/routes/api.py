from flask import Blueprint, request, jsonify
import ollama
from auth.cognito_auth import cognito_auth_required

api_bp = Blueprint('api', __name__)

@api_bp.route('/generate', methods=['POST'])
# @cognito_auth_required
def generate_response():
    print("🚀 ~ generate_response:", generate_response)
    data = request.json
    prompt = data.get('message')
    if not prompt:
        return jsonify({"error": "No prompt provided"}), 400

    messages = [{'role': 'user', 'content': prompt}]
    
    try:
        response = ollama.chat(
            model='adaptive-language-coach:latest',
            messages=messages,
            tools=None
        )
        # print(response)
        model_output = response['message']['content'].strip()
        return jsonify(model_output)
    
    except Exception as e:
        return jsonify({"error": f"Model request failed: {str(e)}"}), 500

@api_bp.route('/conversations', methods=['POST'])
def save_conversation():
    data = request.get_json()
    user_id = data.get('user_id')
    message = data.get('message')
    response = data.get('sender')

    # Save the conversation in DynamoDB
    save_conversation_to_dynamodb(user_id, message, response)

    return jsonify({"status": "success", "message": "Conversation saved"}), 201

@api_bp.route('/conversations', methods=['GET'])
def get_user_conversations():
    user_id = request.args.get('user_id')
    conversations = get_conversations(user_id)
    return jsonify(conversations), 200

@api_bp.route('/conversations/id', methods=['GET'])
def get_conversation():
    conversation_id = request.args.get('conversation_id')
    conversation = get_conversation_by_id(conversation_id)
    
    if conversation:
        return jsonify(conversation), 200
    else:
        return jsonify({"status": "error", "message": "Conversation not found"}), 404
