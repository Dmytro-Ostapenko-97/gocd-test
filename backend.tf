terraform {
  required_version = "= 0.12.28"
  backend "s3" {
    bucket = "jackbot-greg-solution-terraform-state"
#    key = "gocd-test.tfstate"
    region = "us-east-1"
    //dynamodb_table = "terraform-remote-state-lock-db"
  }
}


XPBf3Md7MZwdts


pipeline {
  agent none

  stages {
    stage('Test') {
      agent any
      steps {
        script {
          sh '''
		  echo ${STORE_CODE}'''
        }
      }
    }
	}
}


curl -d "STORE_CODE=test" -i -X POST https://dmytro_ostapenko:114a820a8760fda00155b7abb0d01ae157@jenkins.gregacademy.icu/job/test/buildWithParameters

curl -d "token=XPBf3Md7MZwdts&STORE_CODE=Test" -i -X POST https://dmytro_ostapenko:114a820a8760fda00155b7abb0d01ae157@jenkins.gregacademy.icu/job/test/buildWithParameters

curl -d STORE_CODE=test -i -X POST https://dmytro_ostapenko:114a820a8760fda00155b7abb0d01ae157@jenkins.gregacademy.icu/job/test/buildWithParameters?token=XPBf3Md7MZwdts


curl -d "STORE_CODE=TEST1" -i -X POST https://dmytro_ostapenko:114a820a8760fda00155b7abb0d01ae157@jenkins.gregacademy.icu/job/test/buildWithParameters

pipeline {
  agent none

  stages {
    stage('Test') {
      agent any
      steps {
        script {
          sh '''
		  echo ${STORE_CODE}'''
        }
        
      dir("${env.WORKSPACE}/test_folder") {
        sh '''
        pwd'''
      }
      
      }
    }
  }
  
}

import jenkins.model.*

def matchedJobs = Jenkins.instance.items.findAll { job ->
    job.name =~ /${STORE_CODE}/
}
    
matchedJobs.each { job ->
    println job.name
    job.delete()
}