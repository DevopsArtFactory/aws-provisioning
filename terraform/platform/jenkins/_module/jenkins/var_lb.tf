variable "lb_variables" {
  default = {

    target_group_slow_start = {}

    target_group_deregistration_delay = {}

    internal_lb = {
      tags = {}
    }

    internal_lb_tg = {
      tags = {}
    }

    external_lb = {
      tags = {}
    }

    external_lb_tg = {
      tags = {}
    }
  }
}
