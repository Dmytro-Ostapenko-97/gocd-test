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

curl -XPOST https://jenkins.gregacademy.icu/job/test/doDelete --user dmytro_ostapenko:114a820a && if %{http_code} -ne 200; then echo ERROR fi

curl -XPOST https://jenkins.gregacademy.icu/job/test/doDelete --user dmytro_ostapenko:114a820a --fail

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

apiVersion: v1
kind: Pod
metadata:
  name: pod-name-prefix-{{ POD_POSTFIX }}
  labels:
    app: web
spec:
  volumes:
    - name: goserver-vol
      nfs:
        server: fs-0d0caa8e.efs.us-east-1.amazonaws.com
        path: /
  containers:
    - name: gocd-agent-container-{{ CONTAINER_POSTFIX }}
      image: gregsolutions/gocd-agent-dind:v20.3.0-1.1
      env:
        - name: TF_VERSION
          value: 0.12.29
        - name: USERNAME
          valueFrom:
            secretKeyRef:
              name: secrets
              key: jenkins_username
        - name: USER_API_TOKEN
          valueFrom:
            secretKeyRef:
              name: secrets
              key: jenkins_api_token
      securityContext:
        privileged: true
      volumeMounts:
        - name: goserver-vol
          mountPath: /home/go
          subPath: gocd/homego
          mountPropagation: None

server-sniped kuber