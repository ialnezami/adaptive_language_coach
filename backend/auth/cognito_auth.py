import requests
from jose import jwt
from config import Config

def cognito_auth_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.headers.get("Authorization")
        if not token:
            return jsonify({"message": "Authorization token is missing"}), 401
        
        try:
            # Clean the token (remove 'Bearer ' part)
            token = token.replace("Bearer ", "")
            payload = validate_jwt(token)  # validate_jwt is your previous function
            if not payload:
                return jsonify({"message": "Invalid token"}), 401
        except Exception as e:
            return jsonify({"message": "Token validation error", "error": str(e)}), 401
        
        return f(*args, **kwargs)
    return decorated_function

def get_signing_key(token):
    # Get the Cognito JWK URL
    response = requests.get(Config.COGNITO_JWK_URL)
    jwks = response.json()

    # Parse the key and find the one corresponding to the JWT header
    unverified_header = jwt.get_unverified_header(token)
    if unverified_header is None:
        raise Exception("Unable to find unverified header")

    rsa_key = {}
    for key in jwks['keys']:
        if key['kid'] == unverified_header['kid']:
            rsa_key = {
                'kty': key['kty'],
                'kid': key['kid'],
                'use': key['use'],
                'n': key['n'],
                'e': key['e']
            }
            break
    
    if rsa_key:
        return rsa_key
    else:
        raise Exception("Unable to find appropriate key")

def validate_jwt(token):
    try:
        signing_key = get_signing_key(token)
        payload = jwt.decode(token, signing_key, algorithms=["RS256"], audience=Config.COGNITO_CLIENT_ID)
        return payload
    except Exception as e:
        print(f"Token validation error: {e}")
        return None
