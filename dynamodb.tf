module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name                = "my-table-${var.name}"
  hash_key            = "id"
  range_key           = "title"
  billing_mode        = "PROVISIONED"
  read_capacity       = 2
  write_capacity      = 2
#   autoscaling_enabled = true

#   autoscaling_read = {
#     scale_in_cooldown  = 50
#     scale_out_cooldown = 40
#     target_value       = 45
#     max_capacity       = 10
#   }

#   autoscaling_write = {
#     scale_in_cooldown  = 50
#     scale_out_cooldown = 40
#     target_value       = 45
#     max_capacity       = 10
#   }

#   autoscaling_indexes = {
#     TitleIndex = {
#       read_max_capacity  = 30
#       read_min_capacity  = 10
#       write_max_capacity = 30
#       write_min_capacity = 10
#     }
#   }

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    }
  ]

#   global_secondary_indexes = [
#     {
#       name               = "TitleIndex"
#       hash_key           = "title"
#       range_key          = "age"
#       projection_type    = "INCLUDE"
#       non_key_attributes = ["id"]
#       write_capacity     = 10
#       read_capacity      = 10
#     }
#   ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

resource "null_resource" "example1" {
  provisioner "local-exec" {
    command = "./db.sh"
  }
  depends_on = [
    module.dynamodb_table
  ]
}