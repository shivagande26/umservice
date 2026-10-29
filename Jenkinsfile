pipeline {
  agent any

  parameters {
    string(name: "App_Version", description: "provide application version")
  }

  stages {
    stage("Checkout") {
      steps {
        checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/shivagande26/umservice.git']])
      }
    }
    stage("Maven Build") {
      steps {
        sh """
            echo "-------- Building Application --------"
            mvn clean package
            echo "------- Application Built Successfully --------"
        """
      }
    }
    stage("Maven Test") {
      steps {
        sh """
          echo "-------- Executing Testcases --------"
          mvn test
          echo "-------- Testcases Execution Complete --------"
        """
      }
    }
    stage("Artifact Store") {
      steps {
        sh """
          echo "-------- Pushing Artifacts To S3 --------"
          aws s3 cp ./target/*.jar s3://datastore-artefact-store-app-jenkins/
          echo "-------- Pushing Artifacts To S3 Completed --------"
        """
      }
    }
    stage("Docker Image Build") {
      steps {
        sh """
          echo "-------- Building Docker Image --------"
          docker build -t umservice:"${App_Version}" .
          echo "-------- Image Successfully Built --------"
        """
      }
    }
    // stage("docker image scan") {
    //   steps {
    //     sh """
    //       echo "-------- Scanning Docker Image --------"
    //       trivy image --cache-dir /test/.trivycache umservice:"${App_Version}"
    //       echo "-------- Scanning Docker Image Complete --------"
    //     """
    //   }
    // }
    stage("Docker Image Tag") {
      steps{
        sh """
          echo "-------- Tagging Docker Image --------"
          docker tag umservice:"${App_Version}" 8072388539/umservice:"${App_Version}"
          echo "-------- Tagging Docker Image Completed."
        """
      }
    }
  }
}
