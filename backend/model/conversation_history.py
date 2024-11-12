import boto3
from boto3.dynamodb.conditions import Key
import uuid
import datetime

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('ConversationHistory')

def save_conversation_to_dynamodb(user_id, message, response):
    conversation_id = str(uuid.uuid4())  # Generate a unique ID for the conversation
    timestamp = str(datetime.datetime.utcnow())

    # Save conversation in DynamoDB
    table.put_item(
        Item={
            'conversation_id': conversation_id,
            'user_id': user_id,
            'timestamp': timestamp,
            'message': message,
            'response': response,
        }
    )

def get_conversations(user_id):
    # Fetch conversations from DynamoDB by user_id
    response = table.query(
        KeyConditionExpression=Key('user_id').eq(user_id)
    )
    return response['Items']

def get_conversation_by_id(conversation_id):
    # Fetch a specific conversation by its ID
    response = table.get_item(
        Key={'conversation_id': conversation_id}
    )
    return response.get('Item', None)
