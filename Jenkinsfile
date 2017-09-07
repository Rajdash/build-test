node {
   def mvnHome
   stage('Preparation') { 
      git 'https://github.com/Rajdash/build-test'
               
      mvnHome = tool 'M3'
   }
   stage('Build') {
    
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
   }
   stage('Results') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   stage ('Deploy') {
       sh "sudo docker build -t rajapp ."
       sh "sudo docker run --rm -d -p 8182:8182 rajapp "
   }
   stage ('Smoke Test') {
       sh "./Smoketest.sh
   }
   post {
        changed {
            script {
                if (currentBuild.currentResult == 'FAILURE') { 
                   emailext subject: 'Build failed  ${env.BUILD_URL} , ${env.BUILD_NUMBER}',
                        body: 'Build Failed Please check'
                        replyTo: 'noReply@gmail.com,
                        to: 'raj.ranjan1989@gmail.com'
                }
            }
        }
   }
       
}
