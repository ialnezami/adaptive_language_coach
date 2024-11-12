from flask import Flask
from routes.api import api_bp  # Importing routes
from config import Config  # Import configuration
import auth.cognito_auth as auth  # Import authentication setup
from flask_cors import CORS

app = Flask(__name__)
CORS(app) 
app.config.from_object(Config)

# Register blueprints
app.register_blueprint(api_bp)

if __name__ == "__main__":
    app.run(debug=True,port=5001)
