variable "lb_variables" {
  default = {

    target_group_slow_start = {
      artpapne2   = 0
    }

    target_group_deregistration_delay = {
      artpapne2    = 60
    }

    external_lb = {
      tags = {
        artpapne2 = {
          Name    = "jenkins-artp_apnortheast2-external-lb"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb_tg = {
      tags = {
        artpapne2 = {
          Name    = "jenkins-artp_apnortheast2-external-tg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }
  }
}
