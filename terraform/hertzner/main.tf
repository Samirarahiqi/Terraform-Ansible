#  required_providers {
#   gitlab = {
#     source = "gitlabhq/gitlab"
#     version = "~> 3.1"
#   } 
# }


variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
  default   = "VLNR0QZk7FhuCAjEWuP7yNWf63CJLhMkMLGIcFdxsQXjsP1nOqofgUSSZph75YXp"
}

#variable "gitlab_access_token"{
#  type = string
#  default = "pLJ1B1VPMNxuCbbgvkVu"
#}

#provider "gitlab" {
#   token = var.gitlab_access_token
#}

#data "gitlab_project" "samira-test" {
#     id = 66
#}

#Add a variable to thr project
#resource "gitlab_project_variable" "sample_project_variable"{
#    project = data.gitlab_project.samira-test.id
#    key = "Samira"
#   value = "Greeting Master!"
#}

variable "instance_count" {
  default = "2"
}

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.31.1"
    }
#      backend "http" {
#  }
##    gitlab = {
#      source = "gitlabhq/gitlab"
#      version = "~> 3.1"
#    } 

  }
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a new SSH key
#resource "hcloud_ssh_key" "default" {
#  name       = "Terraform"
#  public_key = file("~/.ssh/id_rsa.pub")
#}


resource "hcloud_server" "terraform" {
  count       = var.instance_count
  name        = "Terraform-${count.index + 1}"
  server_type = "cx11"
  image       = "ubuntu-18.04"
  location    = "nbg1"
  ssh_keys    = ["samira"]

  network {
    network_id = hcloud_network.privNet.id
}
}









