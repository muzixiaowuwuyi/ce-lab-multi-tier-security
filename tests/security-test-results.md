# Security Test Results - Multi-Tier Architecture

## Test 1: Web Tier Accessibility
- **Command**: `curl http://18.184.84.242`
- **Result**: Success (Received Nginx default page).
- **Explanation**: Web server port 80 is open to the public internet.

## Test 2: SSH via Bastion Host
- **Command**: `ssh -A ec2-user@18.184.84.242` from local.
- **Result**: Success.
- **Explanation**: Bastion SG allows SSH from my local IP.

## Test 3: Direct SSH to Database (Isolation Test)
- **Command**: `ssh -i bootcamp-week2-key.pem ec2-user@18.197.131.239` from local.
- **Result**: `Connection timed out`.
- **Explanation**: **Success.** The database tier is not reachable from the public internet.

## Test 4: App Tier from Web Tier
- **Command**: `nc -zv 172.31.42.154 8080` from Web Instance.
- **Result**: `Ncat: Connection refused.`
- **Explanation**: **Success.** Security groups allow the connection, but no service is listening on 8080 yet.

## Test 5: Database from App Tier
- **Command**: `nc -zv 172.31.35.88 3306` from App Instance.
- **Result**: `Ncat: Connection refused.`
- **Explanation**: **Success.** Security groups allow the connection from App to DB, but MySQL service is not running yet.

## Test 6: Database from Web Tier (Isolation Test)
- **Command**: `nc -zv 172.31.35.88 3306` from Web Instance.
- **Result**: `Ncat: TIMEOUT.`
- **Explanation**: **CRITICAL SUCCESS.** The security group `sg-database` correctly blocks traffic that does not originate from `sg-app-tier`.