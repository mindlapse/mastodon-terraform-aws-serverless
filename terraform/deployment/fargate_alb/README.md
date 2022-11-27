
# Fargate ALB Module

- Creates an ALB
- Creates a listener for the ALB on 80 and 443.
- Port 80 requests are redirected to 443
- You provide an ECS cluster ARN
- The 443 listener is mapped to a target group pointing to the given cluster
