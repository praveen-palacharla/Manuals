provider "aws" {
	region = "us-east-1"
}
resource "aws_s3_bucket" "t_statefile" {
  bucket = "mahesh-vamsi-terraform-states"
  
  lifecycle {
	prevent_destroy = true
  }
  
  versioning {
	enabled = true
  }
  
  server_side_encryption_configuration {
	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
        }
  }
}

resource "aws_dynamodb_table" "t_locks" {
	name = "terraform-up-and-running-locks"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"
	
	attribute {
		name = "LockID"
		type = "S"
	}
}

