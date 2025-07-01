#!/bin/bash

# AWS SSO Login Check Script
# This script checks if the user is logged in to AWS SSO and prompts for login if needed

PROFILE_NAME="dev-generic"

# Function to check if AWS SSO session is valid
check_aws_sso_session() {
    # Check if the profile exists and has valid credentials
    if aws sts get-caller-identity --profile "$PROFILE_NAME" >/dev/null 2>&1; then
        return 0  # Session is valid
    else
        return 1  # Session is invalid or expired
    fi
}

# Function to perform AWS SSO login
perform_aws_sso_login() {
    echo "🔐 AWS SSO login required for profile: $PROFILE_NAME"
    echo "Please complete the login flow in your browser..."
    
    if aws sso login --profile "$PROFILE_NAME"; then
        echo "✅ AWS SSO login successful!"
        return 0
    else
        echo "❌ AWS SSO login failed. Please try again manually."
        return 1
    fi
}

# Main execution
echo "🔍 Checking AWS SSO login status..."

if check_aws_sso_session; then
    echo "✅ AWS SSO session is valid for profile: $PROFILE_NAME"
else
    echo "⚠️  AWS SSO session is invalid or expired for profile: $PROFILE_NAME"
    perform_aws_sso_login
fi 