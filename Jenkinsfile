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
       sh "sudo docker stop myspringapp"
       sh "sudo docker build -t rajapp ."
       sh "sudo docker run --name myspringapp --rm -d -p 8182:8182  rajapp "
   }
   stage ('Smoke Test') {
       sh " chmod 755 Smoketest.sh"
       sh " sleep 40 "
       sh "./Smoketest.sh"
   }
   post('failure'){
        mail to: 'raj.ranjan1989@gmail.com',
             subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is wrong with ${env.BUILD_URL}"
            }
         
       
       
}
