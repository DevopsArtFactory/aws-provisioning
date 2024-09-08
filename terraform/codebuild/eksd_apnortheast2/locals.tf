locals {
  encrypted_values = data.sops_file.secret_values.data

  jenkins_envirement_variables = [
    {
      env_name  = "SERVICE_NAME",
      env_value = "JENKINS"
    },
    {
      env_name  = "VPC_NAME",
      env_value = "vpc-eksd_apnortheast2"
    },
    {
      env_name  = "TARGET_GROUP_NAME",
      env_value = "jenkins-eksdapne2-ext"
    },
    {
      env_name  = "SECURITY_GROUP_NAME",
      env_value = "jenkins-eksd_apnortheast2"
    },
    {
      env_name  = "EFS_NAME",
      env_value = "jenkins-efs-eksd_apnortheast2"
    },
    {
      env_name  = "ORG_NAME",
      env_value = "DevopsArtFactory"
    },
    {
      env_name  = "TEAM_NAME",
      env_value = "common"
    },
  ]
}