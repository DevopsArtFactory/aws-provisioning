variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        artdapne2 = {
          Name    = "hello-artd_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "hello-artp_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {
        artdapne2 = {
          Name    = "hello-artd_apnortheast2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },
        artpapne2 = {
          Name    = "hello-artp_apnortheast2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }
  }
}
