variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        artpapne2 = {
          Name    = "jenkins-artp_apnortheast2-ec2-sg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {
        artpapne2 = {
          Name    = "jenkins-artp_apnortheast2-external-lb-sg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "artp_apnortheast2"
        }
      }
    }
  }
}
