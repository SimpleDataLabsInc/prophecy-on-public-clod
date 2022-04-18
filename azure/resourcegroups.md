# Resource Groups

In a managed application, the resources are deployed to a resource group that's managed by the publisher of the app, i.e. Prophecy. The resource group will be present in the consumer's subscription, but an identity in the publisher's tenant will have access to the resource group.

## Deployment & Access details
The resources for a Prophecy managed application are deployed in three resource groups. The consumer manages one resource group, and Prophecy manages another resource group. The third resource group is where the AKS(Azure Kubernetes Service) cluster resources are deployed to. 

![14](https://user-images.githubusercontent.com/59466885/163800642-91721760-56c4-46b2-a659-9ea86211bbe6.jpg)

                           

## Application resource group
This resource group holds the managed application instance. This resource group may only contain one resource. The resource type of the managed application is Microsoft.Solutions/applications. The consumer has full access to the resource group and uses it to manage the lifecycle of the managed application.

## Managed resource group
This resource group holds all the resources that are required by the managed Prophecy application. The consumer has limited access to this resource group because the consumer doesn't manage the individual resources for the managed application. In order to provide support and management services, Prophecy will have administrative-level access to this resource group. 
When the consumer deletes the managed application, the managed resource group also gets deleted.

## AKS resource group
Prophecy managed application is deployed as a cloud-native application and it requires a standard Kubernetes cluster. For Azure marketplace deployments, Prophecy leverages AKS(Azure Kubernetes Service) for deploying its microservices. The AKS cluster when deployed will create another resource group that contains the resources required by the Kubernetes cluster such as the virtual machines, storage accounts, and virtual networks.

The consumer has elevated access levels on this resource group. Tampering with this resource group may make the Kubernetes cluster non-functional so consumers have to be careful when modifying this resource group.



