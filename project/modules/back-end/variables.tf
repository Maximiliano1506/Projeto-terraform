variable "vpc_id" {
    description = "VPC ID"
    type        = string  
}
variable "project_name" {
    description = "Project name"
    type        = string
}
variable "project_region" {
    description = "Project region"
    type        = string
}

variable "priv_subnets_id" {
    type        = list(string)
}