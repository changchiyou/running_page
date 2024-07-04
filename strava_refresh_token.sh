#!/bin/bash

# Prompt the user to enter client_id and client_secret
read -p "Enter your client_id: " client_id
read -p "Enter your client_secret: " client_secret

# Step 1: Get authorization code
authorization_url="http://www.strava.com/oauth/authorize?client_id=${client_id}&response_type=code&redirect_uri=http://localhost/exchange_token&approval_prompt=force&scope=read_all,profile:read_all,activity:read_all,profile:write,activity:write"
echo "Please visit the following URL in your browser to authorize(click the button):"
echo $authorization_url
read -p "After authorization, paste the URL you were redirected to here: " redirect_url

# Extract authorization code from redirect URL
authorization_code=$(echo $redirect_url | grep -o 'code=[^&]*' | cut -d= -f2)
# Step 2: Exchange authorization code for access token and refresh token
response=$(curl --silent -X POST https://www.strava.com/oauth/token \
    -F client_id=$client_id \
    -F client_secret=$client_secret \
    -F code=$authorization_code \
    -F grant_type=authorization_code)
# Extract refresh_token from response
refresh_token=$(echo $response | jq -r '.refresh_token')

# Output refresh_token
echo "Your refresh_token is: $refresh_token"
