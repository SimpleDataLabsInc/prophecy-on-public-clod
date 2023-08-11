## Points to note for Private EKS deployment

**1.** In the existing VPC, we need to make sure that below two flags are set to true for private EKS setup to go through -

      - EnableDnsSupport: true    
      - EnableDnsHostnames: true