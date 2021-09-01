#!/usr/bin/env groovy
env.terraform_version = "0.12.31"
def label = "jenkins-vg-agent"
def notify_channel = "#jenkins-notify"

podTemplate(label: label, containers: [
        containerTemplate(name: 'jenkins-agent',
                image: "hashicorp/terraform:${env.terraform_version}",
                ttyEnabled: true,
                command: 'cat')
]) {
    node(label) {
        stage('Notify') {
                slackSend channel: "${notify_channel}", color: "warning", message: "Felicia-EKS cluster updating.. (<${env.BUILD_URL}|see details>)"
        }
        withAWS(credentials: 'Felicia-AWS-Credentials', region: 'ap-southeast-1') {
            container('jenkins-agent'){
                stage('Checkout') {
                    checkout scm
                }
                stage('Terraform init') {
                    sh 'terraform init -input=false'
                }
                stage('Terraform validate') {
                    sh 'terraform validate'
                }
                stage('Terraform fmt') {
                    sh 'terraform fmt'
                }
                stage('Terraform plan') {
                    sh 'terraform plan -out=tfplan -input=false'
                }
                stage('Terraform apply') {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }
}