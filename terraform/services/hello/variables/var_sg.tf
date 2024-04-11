variable "sg_variables" {
  default = {

    ec2 = {
      tags = {

        neopindapne2 = {
          Name    = "hello-neopind_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "neopind_apnortheast2"
        },

        devartdapne2 = {
          Name    = "hello-devartd_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "hello-devarts_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "hello-devartd_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devartd_apnortheast2"
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

        neopindapne2 = {
          Name    = "hello-neopind_apnortheast2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "neopind_apnortheast2"
        },

        devartdapne2 = {
          Name    = "hello-devartd_apnortheast2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "hello-devarts_apnortheast2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

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
