variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        artdapne2 = {
          Name    = "hello2-artd_apnortheast2-ec2-sg"
          app     = "hello2"
          project = "hello2"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "hello2-artp_apnortheast2-ec2-sg"
          app     = "hello2"
          project = "hello2"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {
        artdapne2 = {
          Name    = "hello2-artd_apnortheast2-external-lb-sg"
          app     = "hello2"
          project = "hello2"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },
        artpapne2 = {
          Name    = "hello2-artp_apnortheast2-external-lb-sg"
          app     = "hello2"
          project = "hello2"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }
  }
}
