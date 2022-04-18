# Permissions & Pre-requisites
## Permission
* You require a Contributor or Owner role to install Prophecy IDE via marketplace. A new resource group will be created as part of the installation and all the Prophecy resources will be created inside it. 

## Resource Requirements

Prophecy IDE requires a minimum of 6 Standard_DS4_v2 family types of VMs. Please assign an appropriate quota in your Azure subscription for a region where you are planning to deploy Prophecy. Please contact the Prophecy team to understand your future scaling needs.

### Increase quota
a. In your azure portal, search for quotas and search for instance type dsv2. Choose the location(region) and subscription.  



![one](https://user-images.githubusercontent.com/59466885/163797661-40479f7a-6511-4d73-a971-058a31da87d6.jpg)




b. To increase the quota, click on the edit button and increase the quota to some value more than 45 cores. 

![two](https://user-images.githubusercontent.com/59466885/163797725-76dc9066-0038-46f5-a1dd-6aef0ea7965a.jpg)



TLS
During installation customer can choose the option where Prophecy can manage certificate and domain for the customer. Customer can also choose to deploy their own TLS certificate and manage domain for Prophecy IDE using their own DNS zones. 

![three](https://user-images.githubusercontent.com/59466885/163797761-771f2925-3efe-4d2e-bdc2-f5fba97db758.jpg)



If customer chooses to deploy their own certificates, then they need to be ready with below inputs:

Screenshot 2022-02-15 at 9.21.00 PM.png
Once installation is complete, please reach out to your DNS admin and request him to add a Type A entry for the ProphecyURL. More details here.
