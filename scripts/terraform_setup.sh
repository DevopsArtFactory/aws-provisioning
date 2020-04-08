#!/bin/bash
 
REGION="ap-northeast-2" # Set default region
AWS_OPS=""
declare -r TRUE=0
declare -r FALSE=1
 
ASSUME_ROLE_ARN=""
 
# Please set the vairables below.
# Need to change the role's ARN properly.
PRD_ASSUME_ROLE_ARN=""
 
# Please change to your e-mail.
SESSION_NAME="" 
 
usage (){
 
  echo "usage: terraform_setup.sh
 
  --profile   AWS profile name
  --setup setup temperate AWS key pair
  --clean clean up environment variables"
 
}
 
is_jq_installed(){
 
  if ! type jq >> /dev/null ; then
    echo "You don't have 'jq' installed, please install it first"
    exit 1
  fi
}
 
setup () {
  raw_output=$(aws sts $AWS_OPS \
  assume-role --role-arn $ASSUME_ROLE_ARN \
  --role-session-name $SESSION_NAME)
  
  aws_key_id=$(echo $raw_output | jq .Credentials.AccessKeyId)
  aws_secret_key=$(echo $raw_output | jq .Credentials.SecretAccessKey)
  session_token=$(echo $raw_output | jq .Credentials.SessionToken)
 
  echo "export AWS_ACCESS_KEY_ID=$aws_key_id"
  echo "export AWS_SECRET_ACCESS_KEY=$aws_secret_key"
  echo "export AWS_SESSION_TOKEN=$session_token"
 
}
 
clean (){
 
  export outputvar="unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN"
  echo "unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN"
  eval $outputvar
 
}
 
while [ "$1" != "" ]; do
 
  case $1 in
 
    "--profile")
      shift
      AWS_OPS="--profile $1"
      ;;
 
    "--setup")
      # You can add option if you add another account 
      while [ "$2" != "" ]; do
        case $2 in
          "-p")
            ASSUME_ROLE_ARN=${PRD_ASSUME_ROLE_ARN}
            ;;
          * )
            "usage"
            exit 1
            ;;
 
        esac
        shift
      done
 
      is_jq_installed
      setup
      exit 0
      ;;
 
    "--clean")
      clean
      exit 0
      ;;
 
    * )
      "usage"
      exit 1
      ;;
 
  esac
  shift
done
