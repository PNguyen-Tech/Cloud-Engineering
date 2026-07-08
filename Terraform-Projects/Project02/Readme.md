Project #2 is to create a sample Azure Landing Zon to demonstrate a prebuilt environment that is prepared for resources to be placed. 

First section to create is the providers.tf. This will configure Terraform to talk to Azure. It also tells the Terraform version and Azure provider. An analogy with this is a universal remote control is bought for a TV. In order for the remote to talk to the TV, then I have to program the TV to be able to communicate and assign the buttons to work with the TV. That is a provider. 
To help with understanding the syntax, I used an imaginary company named after my dog, Katsu, to idenitfy the varabiles I can edit. 

Next is the terraform.tfvars file. THis contains the values for the variables. 

To connect everything together, the variables.tf holds the varibles used in the IaC snippet. The values are assigned in the terraform.tfvars. And the Project02.tf will use the code variable and the value assigned to it. 
