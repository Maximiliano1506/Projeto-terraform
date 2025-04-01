variable "vpc_id" {
    type=string
}

variable "project_region" {
    type = string
}

variable "project_name" {
    type=string
}

variable "pub_subnets_id" {
    type = list(string)
}