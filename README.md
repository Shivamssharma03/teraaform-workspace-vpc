For creating workspace run cmd
=
Terraform workspace create dev,
<button onclick="navigator.clipboard.writeText('Terraform workspace create dev')">Copy</button>
Terraform workspace create dev,

Terraform workspace create stage,


Terraform workspace create prod


For switching into workspaces run cmd
=
Terraform workspace select dev , stage , prod 


For enjecting the envs in diffrent workspaces run cmds
=
For dev workspace plan
=
terraform plan -var-file="envs/dev.tfvars"

For dev workspace apply
=
terraform apply -var-file="envs/dev.tfvars"


For stage workspace plan
=
terraform plan -var-file="envs/stage.tfvars"

For stage workspace apply
=
terraform apply -var-file="envs/stage.tfvars"

For prod workspace plan
=
terraform plan -var-file="envs/prod.tfvars"

For prod workspace apply
=
terraform apply -var-file="envs/prod.tfvars"




