from flask import Flask
from routes.api import api_bp  # Importing routes
from config import Config  # Import configuration
import auth.cognito_auth as auth  # Import authentication setup

app = Flask(__name__)
app.config.from_object(Config)

# Register blueprints
app.register_blueprint(api_bp)

if __name__ == "__main__":
    app.run(debug=True)
