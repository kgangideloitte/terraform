pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        timestamps()
        ansiColor('xterm')
    }

    environment {
        REPO = 'elastic-search'
        REGISTRY = 'nexus.raven.s6ef5y.com:5000'
        REGISTRY_LOGIN = credentials('service-jenkins')
        TF_VERSION = '1.0.3'
    }

    stages {
        stage('Cleanup Containers') {
            steps {
                echo "Making sure old containers are removed"
                sh '''
                    set +e
                    sudo podman kill ${REPO}-infra-builder
                    sudo podman rm ${REPO}-infra-builder
                    set -e
                '''
            }
        }
        stage('Get Build Container(s)') {
            steps {
                echo 'Pulling Container(s) to Registry...'
                sh'''
                    sudo podman login --username ${REGISTRY_LOGIN_USR} --password ${REGISTRY_LOGIN_PSW} ${REGISTRY}
                    sudo podman pull ${REGISTRY}/infra-builder:latest
                    sudo podman logout ${REGISTRY}
                '''
            }
        }
        stage('Terraform Plan') {
            when {
                environment name: 'gitlabBranch', value: 'plan'
            }
            steps {
                echo "Terraform Init and Plan"
                sh '''
                    sudo podman run -it -d --rm --name ${REPO}-infra-builder ${REGISTRY}/infra-builder:latest
                    sudo podman cp tf-infrastructure/. ${REPO}-infra-builder:.
                    sudo podman exec ${REPO}-infra-builder terraform init
                    sudo podman exec ${REPO}-infra-builder terraform plan
                    sudo podman kill ${REPO}-infra-builder
                '''
            }
        }
        stage('Ansible Validate') {
            when {
                environment name: 'gitlabBranch', value: 'plan'
            }
            steps {
                echo "Validate Ansible Playbook"
                sh '''
                    sudo podman run -it -d --rm --name ${REPO}-infra-builder ${REGISTRY}/infra-builder:latest
                    sudo podman cp app-config/. ${REPO}-infra-builder:.
                    sudo podman exec ${REPO}-infra-builder ansible-playbook -i inventory.ini install.yml --syntax-check
                    sudo podman kill ${REPO}-infra-builder
                '''
            }
        }
        stage('Terraform Apply') {
            when {
                environment name: 'gitlabBranch', value: 'main'
            }
            steps {
                echo "Terraform Apply"
                sh '''
                    sudo podman run -it -d --rm --name ${REPO}-infra-builder ${REGISTRY}/infra-builder:latest
                    sudo podman cp tf-infrastructure/. ${REPO}-infra-builder:.
                    sudo podman exec ${REPO}-infra-builder terraform init
                    sudo podman exec ${REPO}-infra-builder terraform apply -auto-approve
                    sudo podman kill ${REPO}-infra-builder
                '''
            }
        }
        stage('Ansible Configure') {
            when {
                environment name: 'gitlabBranch', value: 'main'
            }
            steps {
                echo "Ansible Configure"
                sh '''
                    sudo podman run -it -d --rm --name ${REPO}-infra-builder ${REGISTRY}/infra-builder:latest
                    sudo podman cp app-config/. ${REPO}-infra-builder:.
                    chmod 400 pemkeys/*
                    sudo podman cp pemkeys/. ${REPO}-infra-builder:.
                    sudo podman exec ${REPO}-infra-builder ansible-playbook -i inventory.ini install.yml
                    sudo podman kill ${REPO}-infra-builder
                '''
            }
        }
        stage('Environment Cleanup') {
            when {
                environment name: 'gitlabBranch', value: 'destroy'
            }
            steps {
                echo "Terraform Destroy"
                sh '''
                    sudo podman run -it -d --rm --name ${REPO}-infra-builder ${REGISTRY}/infra-builder:latest
                    sudo podman cp tf-infrastructure/. ${REPO}-infra-builder:.
                    sudo podman exec ${REPO}-infra-builder terraform init
                    sudo podman exec ${REPO}-infra-builder terraform destroy -auto-approve
                    sudo podman kill ${REPO}-infra-builder
                '''
            }
        }
    }
}