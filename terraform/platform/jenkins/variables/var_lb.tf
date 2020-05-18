variable "lb_variables" {
  default = {

    target_group_slow_start = {
      dayonepapne2   = 0
    }

    target_group_deregistration_delay = {
      dayonepapne2    = 60
    }

    external_lb = {
      tags = {
        dayonepapne2 = {
          Name    = "jenkins-dayonep_apnortheast2-external-lb"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dayonep_apnortheast2"
        }
      }
    }

    external_lb_tg = {
      tags = {
        dayonepapne2 = {
          Name    = "jenkins-dayonep_apnortheast2-external-tg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dayonep_apnortheast2"
        }
      }
    }
  }
}
