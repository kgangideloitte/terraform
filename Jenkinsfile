pipeline {
    agent any

    environment {
        REPO = 'terraform'
    }

    stages {
        stage('Terraform Plan') {
            when {
                branch 'plan'
            }
            steps {
                echo "Terraform Version, Init, and Plan"
                echo "We are running Terraform version..."
                sh '''
                    terraform -version
                '''
                echo "Terraform Init..."
                sh '''
                    terraform init -no-color
                '''
                echo "Terraform Plan..."
                sh '''
                    terraform plan -no-color
                '''
            }
        }
        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                echo "Terraform Apply"
                echo "We are running Terraform version..."
                sh '''
                    terraform -version
                '''
                echo "Terraform Init..."
                sh '''
                    terraform init -no-color
                '''
                echo "Terraform Apply..."
                sh '''
                    terraform apply -auto-approve -no-color
                '''
            }
        }
        stage('Environment Cleanup') {
            when {
                branch 'destroy'
            }
            steps {
                echo "Terraform Destroy"
                echo "We are running Terraform version..."
                sh '''
                    terraform -version
                '''
                echo "Terraform Init..."
                sh '''
                    terraform init -no-color
                '''
                echo "Terraform Destroy..."
                sh '''
                    terraform destroy -auto-approve -no-color
                '''
            }
        }
    }
}