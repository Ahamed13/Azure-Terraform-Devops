#Define Local values
locals {
  owners = var.business_division
  environment = var.environment
  resources_name_prefix = "${var.business_division}-${var.environment}"
  common_tag = {
    owners = local.owners
    environment = local.environment
  }

  web_custom_data = <<CUSTOM_DATA
  #!/bin/sh
  #!/bin/sh
  sudo yum install -y httpd
  sudo systemctl enable httpd
  sudo systemctl start httpd
  sudo systemctl stop firewalld
  sudo systemctl disable firewalld
  sudo chmod -R 777 /var/ww/html
  sudo echo "Welcome to website -VM HOSTNAME: $(hostname)" > /var/ww/html/index.html
  sudo mkdir /var/ww/html/app1
  sudo echo "Welcome to website -VM HOSTNAME: $(hostname)" > /var/ww/html/app1/hostname.html
  sudo echo "Welcome to website -VM HOSTNAME: $(hostname)- App status Page" > /var/ww/html/app1/status.html
  sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
  sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
  CUSTOM_DATA
}