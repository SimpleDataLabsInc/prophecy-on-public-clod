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



## TLS
During installation customer can choose the option where Prophecy can manage certificate and domain for the customer. Customer can also choose to deploy their own TLS certificate and manage domain for Prophecy IDE using their own DNS zones. 



![three_0](https://user-images.githubusercontent.com/59466885/163798189-d6e3eadd-dd3a-4bf2-8d36-3662301ed8ff.jpg)



If customer chooses to deploy their own certificates, then they need to be ready with below inputs:

![three](https://user-images.githubusercontent.com/59466885/163797761-771f2925-3efe-4d2e-bdc2-f5fba97db758.jpg)

Once installation is complete, please reach out to your DNS admin and request him to add a Type A entry for the ProphecyURL. More details [here](https://coda.io/d/Prophecy-IDE-Deployment_dXZQH4So4mH/Installation_suw7k).


# Installation

Prophecy provides an easy to use visual interface to design and run data pipelines at scale. Azure managed applications enable Prophecy to offer a deployment route that is easy for consumers to deploy Prophecy IDE. To make a managed application available to all customers, Prophecy publishes its Kubernetes based application in the Azure marketplace. Consumers can deploy the required infrastructure with a couple of clicks and get the benefit of automated management and support by the Prophecy team via Azure Marketplace.

## Deploying Prophecy from Azure Marketplace

### Overview
This topic describes how to deploy and launch a Prophecy IDE in Azure from the Azure Marketplace, finish a simple onboarding process and start using our IDE to design and run data pipelines at scale.

The following steps show you how to get Prophecy for Azure up and running via the Azure Marketplace.

![four](https://user-images.githubusercontent.com/59466885/163799304-93582823-2905-45b7-b4d3-193a7cc15a92.jpg)



## Step 1: Pre-requisites
Please check the details in Permissions & Pre-requisites section above. 

## Step 2: Install Prophecy IDE
### 1. Search Prophecy in the Azure Marketplace.
  1. Click on Get It now
  2. In the Create this app in Azure modal, click Continue. You are directed to the Azure portal.
  3. In the portal, click Create to begin the Prophecy IDE setup.


![five](https://user-images.githubusercontent.com/59466885/163799424-593e4157-b3e3-4675-ba02-507113fb28fa.jpg)

### 2. Create Prophecy 
a. Click on Create
1. In the **Basics** tab (default) enter the following.
     **Project Details**
  * **Subscription**: Choose the applicable subscription.
  * **Resource group**: Create a new group or choose an existing one. ( Please check this link to understand more about resource groups for Azure managed applications.)
    ** Instance Details**
  * **Region**: Select the Azure region.
     **Configure TLS**
      Please choose one of the option to manage TLS and Base Domain of your cluster.
      **Option 1**: Please choose Use Prophecy's Base Domain (prophecy.io) and Certificates. Your certificates will be issued by LetsEncrypt, if you want Prophecy to manage the certificates and domain for you. 
     **Option 2**: Please choose Use your own Base Domain and Certificate. We require a wildcard certificate for *.BASEDOMAIN wildcard domain, if you want to manage the certificates and domain. 
     For this option, please give base domain, tls certificate and key. 

     **Managed Application Details**
  *** Application Name**: Give a name for Prophecy managed application. 


![six](https://user-images.githubusercontent.com/59466885/163799533-d2c43fe4-0e54-4a34-be53-9e090bfe7b69.jpg)


### 3. Review + Create. 
a. Agree to the terms & conditions and click **Create** for your deployment to be created. 

![seven](https://user-images.githubusercontent.com/59466885/163799594-6ff30896-99ab-466d-8b6b-a3529e72ed4d.jpg)


### 4. Go to resource. 
a. It takes around 20-30 minutes to finish the installation. Once installation is complete, click on **Go to resource**

![8](https://user-images.githubusercontent.com/59466885/163799813-e269f727-db73-461e-9fe9-ffbb08a1279c.jpg)

b. Click on Parameters and Outputs

![9](https://user-images.githubusercontent.com/59466885/163799821-c547868b-ca28-4f62-851b-777a41368e85.jpg)


c. Note down output parameters
If you have chose Option 1 during installation, i.e _Use Prophecy's Base Domain (prophecy.io) and Certificates. Your certificates will be issued by LetsEncrypt_, then you will be able to access the cluster by noting down **ProphecyURL**, **AdminUser** and **Credentials**.

If you have chose Option 2 during installation, i.e _Use your own Base Domain and Certificate. We require a wildcard certificate for *.BASEDOMAIN wildcard domain_, then please note down **ProphecyURL, LoadBalancer IP, AdminUser** and **Credentials**. Please reach out to your DNS admin and request the admin to add a Type A entry for the ProphecyURL with IP address as LoadBalancer IP. Once this step is done, you can proceed with Step 3 as given below. 

![10](https://user-images.githubusercontent.com/59466885/163799833-e998f38c-4df0-40d0-b215-26eff7c2ffa0.jpg)




## Step 3: Launching and setting up Prophecy IDE
### 1. Launch Prophecy IDE and finish Onboarding
a. **Login**: Open the prophecyURL and login using adminUser and its credentials 
![11](https://user-images.githubusercontent.com/59466885/163799857-0674e97f-a3c1-47b7-9543-7274e16da830.jpg)


b. **Onboarding**: 
Click on Setup to finish the onboarding. 
![12](https://user-images.githubusercontent.com/59466885/163799864-d0e21bd7-32fe-45ae-ac22-ba562c03f04c.jpg)

Setup Fabric to configure Prophecy IDE with your Databricks environment. 
_Note: Fabric is an execution environment. This is where you configure your spark endpoint details, spark credentials, etc._

![13](https://user-images.githubusercontent.com/59466885/163799874-3a8d559e-cd0d-454e-bcc8-f9839325a6b4.jpg)
