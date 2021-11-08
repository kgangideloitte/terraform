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
                    terraform init
                '''
                echo "Terraform Plan..."
                sh '''
                    terraform plan
                '''
            }
        }
        // stage('Terraform Apply') {
        //     when {
        //         branch 'main'
        //     }
        //     steps {
        //         echo "Terraform Apply"
        //         echo "We are running Terraform version..."
        //         sh '''
        //             terraform -version
        //         '''
        //         echo "Terraform Init..."
        //         sh '''
        //             terraform init
        //         '''
        //         echo "Terraform Apply..."
        //         sh '''
        //             terraform apply -auto-approve
        //         '''
        //     }
        // }
        // stage('Environment Cleanup') {
        //     when {
        //         branch 'destroy'
        //     }
        //     steps {
        //         echo "Terraform Destroy"
        //         echo "We are running Terraform version..."
        //         sh '''
        //             terraform -version
        //         '''
        //         echo "Terraform Init..."
        //         sh '''
        //             terraform init
        //         '''
        //         echo "Terraform Destroy..."
        //         sh '''
        //             terraform destroy -auto-approve
        //         '''
        //     }
    }
}