pipeline {
  agent any

  stages {
    stage("checkout") {
      steps {
        checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/shivagande26/umservice.git']])
      }
    }
  }
}
