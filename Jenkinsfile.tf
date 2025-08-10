pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('clone Repository') {
            steps {
                git 'https://github.com/Durga0720/pipeline_1'

            }
        }

        stage ('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
    }

    stage ('Terraform plan') {
        steps {
            sh 'terraform plan -out=tfplan'
        }
    }

    stage('Terraform Apply') {
        steps {
            sh 'terraform apply -auto-approve tfplan'
        }
    }

    stage('Verification') {
        steps {
            sh 'aws ec2 describe-instances --region ap-south-1'

        }
    }

}
