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
    }
}