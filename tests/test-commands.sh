#!/bin/bash

# --- Local Ubuntu Terminal ---
# Step 1: Add key and test SSH Forwarding
eval `ssh-agent -s`
ssh-add ~/.ssh/bootcamp-week2-key.pem
ssh -A ec2-user@18.184.84.242

# --- Web Instance Terminal (172.31.37.201) ---
# Step 2: Install tools and test connection to App Tier
sudo dnf install nc -y
nc -zv 172.31.42.154 8080   # Expected: Connection refused (Security Group open)

# Step 3: Test isolation (Direct connection to DB)
nc -zv 172.31.35.88 3306    # Expected: TIMEOUT (Security Group blocked)

# Step 4: Jump to App Tier
ssh 172.31.42.154

# --- App Instance Terminal (172.31.42.154) ---
# Step 5: Install tools and test connection to DB Tier
sudo dnf install nc -y
nc -zv 172.31.35.88 3306    # Expected: Connection refused (Security Group open)