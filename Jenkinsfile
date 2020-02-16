pipeline {
   agent any
   
   environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
        TF_VAR_IP = 'initial'
    } 

   stages {
      stage('Run the aws instance with selenoid') {
         steps {
            sh "echo $TF_VAR_IP"
            sh "terraform init -input=false"
            sh "terraform plan -lock=false"
            sh "terraform apply -input=false -auto-approve"
            sh 'terraform output aws_instance_public_ip > ip.txt'
            script{
               TF_VAR_IP = readFile('ip.txt').trim()
            }
            sh "echo $TF_VAR_IP"
            sleep 120
            }
         }
    stage('Test suite is in progress') {
         steps {
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
              build job: "Autotests_run", 
                    parameters: [string(name: 'ip', value: String.valueOf(TF_VAR_IP))]                
            }                
            }
            
         }
      
    stage('Destroy the aws instance') {
         steps {
            sh "terraform destroy -auto-approve -target aws_instance.ubuntu_selenoid"
            }
         }
   }
}
