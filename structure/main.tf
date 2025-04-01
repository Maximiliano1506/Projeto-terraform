resource "aws_s3_bucket" "terraform_state" {
    bucket = "gabriel-terraform-state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = true
    }
}