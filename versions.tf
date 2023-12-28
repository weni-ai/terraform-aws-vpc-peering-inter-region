terraform {
  required_version = ">= 0.12.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.accepter,
        aws.requester
      ]

      version = ">= 4.0"
    }
  }
}
