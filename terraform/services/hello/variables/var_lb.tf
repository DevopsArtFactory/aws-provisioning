variable "lb_variables" {
  default = {

    target_group_slow_start = {
      devartdapne2 = 0
      artdapne2 = 0
      artpapne2 = 0
    }

    target_group_deregistration_delay = {
      devartdapne2 = 0
      artdapne2 = 60
      artpapne2 = 60
    }

    external_lb = {
      tags = {

        devartdapne2 = {
          Name    = "hello-devartd_apnortheast2-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        artdapne2 = {
          Name    = "hello-artd_apnortheast2-external-lb"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "hello-artp_apnortheast2-external-lb"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb_tg = {
      tags = {

        devartdapne2 = {
          Name    = "hello-devartd_apnortheast2-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "devartd_apnortheast2"
        },

        artdapne2 = {
          Name    = "hello-artd_apnortheast2-external-tg"
          app     = "hello"
          project = "hello"
          env     = "dev"
          stack   = "artd_apnortheast2"
        },

        artpapne2 = {
          Name    = "hello-artp_apnortheast2-external-tg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }
  }
}
