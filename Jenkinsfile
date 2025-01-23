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
                sh 'terraform plan -out=tfplan'
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
