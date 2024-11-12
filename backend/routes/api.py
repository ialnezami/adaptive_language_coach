from flask import Blueprint, request, jsonify
import ollama
from auth.cognito_auth import cognito_auth_required

api_bp = Blueprint('api', __name__)

@api_bp.route('/generate', methods=['POST'])
# @cognito_auth_required
def generate_response():
    data = request.json
    prompt = data.get('prompt')
    
    if not prompt:
        return jsonify({"error": "No prompt provided"}), 400

    messages = [{'role': 'user', 'content': prompt}]
    
    try:
        response = ollama.chat(
            model='adaptive_language_coach',
            messages=messages,
            tools=None
        )
        
        model_output = response.get('content', '')
        return jsonify({"response": model_output})
    
    except Exception as e:
        return jsonify({"error": f"Model request failed: {str(e)}"}), 500
