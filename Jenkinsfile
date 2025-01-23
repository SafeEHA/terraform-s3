pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-west-2'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SafeEHA/terraform-s3.git'
            }
        }
        stage('AWS Credentials') {
            steps {
                withCredentials([
                    [
                        $class: 'AmazonWebServicesCredentialsBinding', 
                        credentialsId: 'my-cba-aws-credential',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]
                ]) {
                    sh '''
                    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                    aws configure set default.region $AWS_REGION
                    aws configure list
                    '''
                }
            }
        }
        stage('Install Terraform') {
            steps {
                sh 'terraform --version || sudo apt-get install terraform -y'
            }
        }
        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan Terraform') {
            steps {
                sh '''
                echo "Current Directory:"
                pwd
                echo "Terraform Files:"
                ls
                terraform plan -detailed-exitcode -out=tfplan
                '''
            }
        }
        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    post {
        always {
            sh 'rm -f tfplan'
        }
        success {
            echo 'Terraform deployment successful!'
        }
        failure {
            echo 'Terraform deployment failed.'
        }
    }
}
