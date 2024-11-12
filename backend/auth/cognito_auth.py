from flask import request, jsonify
from config import Config
import jwt
from jwt import PyJWKClient

def validate_jwt(token):
    try:
        jwks_client = PyJWKClient(Config.COGNITO_JWK_URL)
        signing_key = jwks_client.get_signing_key_from_jwt(token)
        payload = jwt.decode(token, signing_key.key, algorithms=["RS256"], audience=Config.COGNITO_CLIENT_ID)
        return payload
    except Exception as e:
        print(f"Token validation error: {e}")
        return None

def cognito_auth_required(f):
    def wrapper(*args, **kwargs):
        token = request.headers.get("Authorization", "").replace("Bearer ", "")
        if not token:
            return jsonify({"error": "Authorization token missing"}), 401
        payload = validate_jwt(token)
        if not payload:
            return jsonify({"error": "Invalid token"}), 401
        return f(*args, **kwargs)
    return wrapper
