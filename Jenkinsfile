pipeline
{
    environment
    {
        registry = "mayurj02/calculator"
        registryCredential = 'dockerhub'
        dockerImage = ''
        dockerImageLatest = ''
    }
    agent any
    stages
    {
        stage('Cloning Git')
        {
            steps
            {
                echo 'Pulling the Maven Git repo'
                git "https://github.com/mayurjain02/Calculator_DevOps.git"
            }
        }

        stage("Clean")
        {
            steps
            {
                echo "Cleaning the project"
                sh " mvn clean"
            }
        }
        stage("Package")
        {
            steps
            {
                echo "Packaging the project"
                sh "mvn package"
            }
        }
        stage("Install")
        {
            steps
            {
                echo "Installing the project"
                sh "mvn install"
            }
        }
        stage('Build Image')
        {
            steps
            {
                script
                {
                  dockerImage = docker.build registry + ":$BUILD_NUMBER"
                  dockerImageLatest = docker.build registry + ":latest"
                }
            }
        }
        stage('Deploy Image to DockerHub')
        {
            steps
            {
                script
                {
                    docker.withRegistry( '', registryCredential )
                    {
                        dockerImage.push()
                        dockerImageLatest.push()
                    }
                }
            }
        }
        stage('Remove Unused Docker image')
        {
            steps
            {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
        stage("Running Calculator")
        {
            steps
            {
                echo "Run the Calculator"
                sh "java -cp target/calculator.jar com/calculator/Calculator 5+5*7"
            }
        }
    }
}
