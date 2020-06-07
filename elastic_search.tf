resource "aws_instance" "ElasticSearch-Cluster" {

// ami = "${var.mydefami}"
ami = var.mydefami
 instance_type = var.mydefinsttype
 vpc_security_group_ids = ["${aws_security_group.elasticsearch_securitygroup.id}"]
 tags = {
	 Name = "ElasticSearchHost"
 }
 
 user_data = <<EOF
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum update -y
yum install docker -y
service docker start
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
EOF
}
