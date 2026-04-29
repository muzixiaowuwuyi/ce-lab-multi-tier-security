
# README.md 
Document:
## Your security design philosophy

    We use a "Defense in Depth" strategy to secure the application. Each layer is isolated and follows the Principle of Least Privilege, ensuring that only necessary traffic is allowed between tiers.

## How each tier protects the next

    Traffic is strictly controlled: the Web tier only talks to the App tier, and the App tier is the only one that can access the Database. All management access is hidden behind a single Bastion Host to minimize the attack surface.

## Why you made specific rule decisions

    We chose Security Group Referencing instead of static IPs to make the setup scalable and dynamic. This ensures that even if we add more servers, the security rules will automatically apply without manual updates.


## Testing methodology and results
    We followed a dual-testing approach: first, Negative Testing to ensure unauthorized cross-tier access (e.g., Web to DB) was blocked with a TIMEOUT. Second, Positive Testing using nc -zv and curl to verify that authorized traffic flowed correctly between the Web, App, and Database tiers.

## Challenges and learnings
    The biggest challenge was managing SSH connectivity without exposing private keys; I learned how to use SSH Agent Forwarding (ssh -A) to solve this. I also gained a deep understanding of why Security Group Referencing is superior to IP-based rules for building dynamic, scalable, and secure cloud environments.
