#!/usr/bin/env groovy
env.terraform_version = "0.12.31"
def label = "jenkins-vg-agent"
def notify_channel = "#jenkins-notify"
properties([parameters([
        choice(choices: ["create", "remove"].join("\n"), description: "Create or remove cluster", name: "terraform_action")
])])

podTemplate(label: label, containers: [
        containerTemplate(name: 'jenkins-agent',
                image: "greghu/terraform-0.12.31:latest",
                ttyEnabled: true,
                command: 'cat')
]) {
    node(label) {
        stage('Notify') {
                slackSend channel: "${notify_channel}", color: "warning", message: "Felicia-EKS cluster updating.. (<${env.BUILD_URL}|see details>)"
        }
        withAWS(credentials: 'ritz-aws-credentials', region: 'ap-southeast-1') {
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
                    if (env.terraform_action == "create") {
                        sh 'terraform apply -input=false tfplan'
                    } else {
                        echo "Skip Apply due to not match."
                    }
                }
                stage('Terraform destroy') {
                    if (env.terraform_action == "remove") {
                        sh 'terraform destroy -auto-approve'
                    } else {
                        echo "Skip Destroy due to not match."
                    }
                }
                stage('Notify') {
                slackSend channel: "${notify_channel}", color: "good", message: "Felicia-EKS is reaaady.. (<${env.BUILD_URL}|see details>)"
                }
            }
        }
    }
}