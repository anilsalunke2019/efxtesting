pipeline {
    agent any
    tools {
        terraform 'Terraform'
    }
    properties([
        parameters([
                extendedChoice(defaultValue: 'dev,qa', description: 'What environment(s)?', multiSelectDelimiter: ',', name: 'environments', quoteValue: false, saveJSONParameterToFile: false, type: 'PT_MULTI_SELECT', value: 'dev,qa,int,int2,uat-prod,prd,dint-int-ca,dint-uatp-ca,dint-prd-ca,dint-int-au,dint-uatp-au,dint-prd-au,dint-int-uk,dint-uatp-uk,dint-prd-uk,dint-int-ind,dint-uatp-ind,dint-prd-ind,dint-int-lat,dint-uatp-lat,dint-prd-lat, int-eu, uat-ca, uat-uk, uat-eu, uat-au, uat-lat, uat-ind, prd-ca, prd-uk, prd-eu, prd-au, prd-ind, prd-lat', visibleItemCount: 39),
        choice(choices: ['plan', 'apply', 'destroy'], description: 'Terraform command', name: 'terraformCommand' ),
				choice(choices: ['everything',
				                 'alerts',
				                 'notification-channel',
				                 'hop-dataflow',
				                 'gcs',
				                 'gce',
				                 'iam-roles',
				                 'kubernetes-secret',
				                 'pubsub',
				                 'serviceaccount',
				                 'bigquery',
				                 'bq_data_transfer',
				                 'update_bigquery_businessevents_schema',
				                 'reimport-pubsub-opintel-monitoring',
				                 'reimport_bq_tables_cmek',
                         'bigtable',
				                 'global-bucket'], description: 'What Terraform module should be executed?', name: 'module' )
        ])
])
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