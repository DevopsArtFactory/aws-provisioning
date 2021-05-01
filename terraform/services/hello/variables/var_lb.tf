variable "lb_variables" {
  default = {

    target_group_slow_start = {
      artdapne2 = 0
      artpapne2 = 0
    }

    target_group_deregistration_delay = {
      artdapne2 = 60
      artpapne2 = 60
    }

    external_lb = {
      tags = {
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
