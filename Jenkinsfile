pipeline {
    agent any
    tools {
        terraform 'Terraform'
    }
    parameters {
        choice(name: "ENV", choices: ["", "ENG", "SA", "IST"])
    }
    environment {
        PROJECT_ID = 'ngtest-356407'
        CLUSTER_NAME = 'assignment-gke'
        LOCATION = 'us-east1-b'
        CREDENTIALS_ID = 'gke'
    }
    stages {
        stage('Git checkout') {
           steps{
                git branch: 'main', credentialsId: 'Github', url: 'git@github.com:anilsalunke2019/efxtesting.git'
            }
        }
    stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
    stage('terraform Init') {
            steps{
                sh 'terraform init -var-file="secret.tfvars"'
            }
        }
    stage('terraform Plan') {
            steps{
                sh 'terraform plan -out tfplan -var-file="secret.tfvars"'
            }   
         }
    stage("DEV Deployment") {
                    when { expression { params.DEPLOY_TO == "DEV" } }
                    steps {
                       sh 'terraform plan -out tfplan -target="google_storage_bucket.DEV-bucket" -var-file="secret.tfvars"'
                       sh 'terraform apply -auto-approve -target="google_storage_bucket.DEV-bucket" -var-file="secret.tfvars"'
                    }
                }
            

    stage("QA Deployment") {
                    when { expression { params.DEPLOY_TO == "QA" } }
                    steps {
                       sh 'terraform apply -auto-approve -target="google_storage_bucket.QA-bucket"'
                    }
                }
            

    }
}