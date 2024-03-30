variable "lb_variables" {
  default = {

    target_group_slow_start = {
      devartdapne2 = 0
      devartsapne2 = 0
      artdapne2 = 0
      artpapne2 = 0
    }

    target_group_deregistration_delay = {
      devartdapne2 = 0
      devartsapne2 = 0
      artdapne2 = 60
      artpapne2 = 60
    }

    external_lb = {
      tags = {

        devartdapne2 = {
          Name    = "helloapi-devartd_apnortheast2-external-lb"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloapi-devarts_apnortheast2-external-lb"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloapi-artd_apnortheast2-external-lb"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "helloapi-artp_apnortheast2-external-lb"
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
          Name    = "helloworker-devartd_apnortheast2-internal-lb"
          app     = "helloworker"
          project = "helloworker"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloworker-devarts_apnortheast2-internal-lb"
          app     = "helloworker"
          project = "helloworker"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloworker-artd_apnortheast2-internal-lb"
          app     = "helloworker"
          project = "helloworker"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "helloworker-artp_apnortheast2-internal-lb"
          app     = "helloworker"
          project = "helloworker"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb_tg = {
      tags = {

        devartdapne2 = {
          Name    = "helloapi-devartd_apnortheast2-external-tg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloapi-devarts_apnortheast2-external-tg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloapi-artd_apnortheast2-external-tg"
          app     = "helloapi"
          project = "helloapi"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "helloapi-artp_apnortheast2-external-tg"
          app     = "helloapi"
          project = "helloapi"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    internal_lb_tg = {
      tags = {

        devartdapne2 = {
          Name    = "helloworker-devartd_apnortheast2-internal-tg"
          app     = "helloworker"
          project = "helloworker"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        devartsapne2 = {
          Name    = "helloworker-devarts_apnortheast2-internal-tg"
          app     = "helloworker"
          project = "helloworker"
          env     = "dev"
          stack   = "devarts_apnortheast2"
        },

        artdapne2 = {
          Name    = "helloworker-artd_apnortheast2-internal-tg"
          app     = "helloworker"
          project = "helloworker"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "helloworker-artp_apnortheast2-internal-tg"
          app     = "helloworker"
          project = "helloworker"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }
  }
}
