#!/bin/bash
# Please make sure AWSCLI and JQ are installed

set +e

if [ $# -lt 5 ]
  then
    echo "Invalid Number of arguments provided."
    echo "Please run the script as following - \n\t./tag_dependent_resources.sh <clusterName> <asgName> <region> <tagKey> <tagValue>"
    exit 1
fi

clusterName=$1
asgName=$2
region=$3
tagKey=$4
tagValue=$5

echo "Request for tagging all dependent resources of cluster $clusterName with tag as $tagKey:$tagValue"
read -p "Do you wish to proceed? (yes/no) " yn

case $yn in
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

echo "Proceed for tagging cluster $clusterName's resources with tag as $tagKey:$tagValue"
clusterDetails=$(aws eks describe-cluster --name $clusterName --region $region --output json)

# Tag EKS
clusterARN=$(echo $clusterDetails | jq -r .cluster.arn)
aws eks tag-resource --resource-arn $clusterARN --region $region --tags $tagKey=$tagValue

# Tag ASG
if [[ -z "$asgName" ]]
then
    echo "No ASG passed"
else
    echo "Tagging ASG $asgName"
    aws autoscaling create-or-update-tags --region $region --tags ResourceId=$asgName,ResourceType=auto-scaling-group,Key=Name,Value=$asgName,PropagateAtLaunch=false ResourceId=$asgName,ResourceType=auto-scaling-group,Key=$tagKey,Value=$tagValue,PropagateAtLaunch=true
fi

# Tag all dependent resources
num=1
tagBasedARNs=$(aws resourcegroupstaggingapi get-resources --region $region --tag-filters Key=kubernetes.io/cluster/$clusterName --output json | jq -r .ResourceTagMappingList | jq -r ".[] | .ResourceARN")
read -a tagBasedARNArray <<< $tagBasedARNs
for arn in ${tagBasedARNArray[@]}; do
    echo "Tagging $num / ${#tagBasedARNArray[@]} resources. Current resource: $arn"
    aws resourcegroupstaggingapi tag-resources --resource-arn-list $arn --region $region --tags $tagKey=$tagValue
    ((num++))
done

echo "Automated tagging complete"
echo "Please follow the following link to tag all CSI Volumes with desired tags = https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/tagging.md"

# UNCOMMENT BLOCK BELOW IF TO BE TAGGED SEPERATELY. CURRENTLY HANDLED BY KUBERNETES CLUSTER TAG FORMAT
#
# VPCID=$(echo $clusterDetails | jq -r .cluster.resourcesVpcConfig.vpcId)
# subnets=$(echo $clusterDetails | jq -r .cluster.resourcesVpcConfig.subnetIds)
# subnetArray=$(echo "$subnets" | jq -c -r '.[]')
# aws ec2 create-tags --resources $VPCID --region $region --tags Key=$tagKey,Value=$tagValue
# for subnet in ${subnetArray[@]}; do
#     aws ec2 create-tags --resources $subnet --region $region --tags Key=$tagKey,Value=$tagValue
# done
