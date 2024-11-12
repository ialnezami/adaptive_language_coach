class Config:
    COGNITO_POOL_ID = "us-west-2_example"
    COGNITO_REGION = "us-west-2"
    COGNITO_CLIENT_ID = "your_app_client_id"
    COGNITO_JWK_URL = f"https://cognito-idp.{COGNITO_REGION}.amazonaws.com/{COGNITO_POOL_ID}/.well-known/jwks.json"
