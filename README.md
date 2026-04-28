
# README.md 
Document:
## Your security design philosophy

    We use a "Defense in Depth" strategy to secure the application. Each layer is isolated and follows the Principle of Least Privilege, ensuring that only necessary traffic is allowed between tiers.

## How each tier protects the next

    Traffic is strictly controlled: the Web tier only talks to the App tier, and the App tier is the only one that can access the Database. All management access is hidden behind a single Bastion Host to minimize the attack surface.

## Why you made specific rule decisions

    We chose Security Group Referencing instead of static IPs to make the setup scalable and dynamic. This ensures that even if we add more servers, the security rules will automatically apply without manual updates.


## Testing methodology and results


## Challenges and learnings

