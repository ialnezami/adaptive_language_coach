# Use the official Ollama image as the base
FROM ollama/ollama:latest

# Set environment variables
ENV API_PORT=11400

# Create a directory for models if it doesn't exist and copy the modelfile
WORKDIR /models
COPY ./models/modelfile /models/modelfile

# Expose the port specified in the environment variable
EXPOSE ${API_PORT}

# Run the command to create the model on container start
CMD ["ollama", "create", "adaptive-language-coach", "--from", "-f", "./Modelfile"]



