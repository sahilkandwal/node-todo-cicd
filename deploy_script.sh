#!/bin/bash

# Navigate to the deployment directory
cd /home/ubuntu/deploy

# Example commands to deploy your application
# You might need to kill existing processes or start new ones
npm install
npm start &

echo "Deployment completed successfully."
