variable "sg_variables" {
  default = {

    ec2 = {
      tags = {

        devartdapne2 = {
          Name    = "helloapi-devartd_apnortheast2-ec2-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloapi-devarts_apnortheast2-ec2-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloapi-devartd_apnortheast2-ec2-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        artpapne2 = {
          Name    = "helloapi-artp_apnortheast2-ec2-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {

        devartdapne2 = {
          Name    = "helloapi-devartd_apnortheast2-external-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloapi-devarts_apnortheast2-external-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloapi-artd_apnortheast2-external-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },
        artpapne2 = {
          Name    = "helloapi-artp_apnortheast2-external-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }

      }
    }

    internal_lb = {
      tags = {

        devartdapne2 = {
          Name    = "helloapi-devartd_apnortheast2-internal-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloapi-devarts_apnortheast2-internal-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloapi-artd_apnortheast2-internal-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },
        artpapne2 = {
          Name    = "helloapi-artp_apnortheast2-internal-lb-sg"
          app     = "helloapi"
          project = "helloapi"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
     }
    }  


  }
}
