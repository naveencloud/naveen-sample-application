#!groovy

// Terraform apply or plan via the Makefile
// Terraform apply or plan via the Makefile
def TerraApply(String LayerToDeploy, String Environment, String EC2_KEYPAIR_NAME, String TerraAction) {
    // force all non apply requests to plan
    // if (TerraAction != 'apply') {
    //     TerraAction = 'plan'
    // }
    sh """
        set +x
        echo "=== Terraform ${TerraAction} for ${LayerToDeploy} in ${Environment} ==="
        LAYER=${LayerToDeploy} WORKSPACE=${Environment} EC2_KEYPAIR_NAME=${EC2_KEYPAIR_NAME} make first-run
        LAYER=${LayerToDeploy} WORKSPACE=${Environment} EC2_KEYPAIR_NAME=${EC2_KEYPAIR_NAME} make init
        LAYER=${LayerToDeploy} WORKSPACE=${Environment} EC2_KEYPAIR_NAME=${EC2_KEYPAIR_NAME} make ${TerraAction}
        """
}
pipeline {	
	agent any 
    parameters {
		booleanParam(name: '_1_APPLICATION_INFRA', defaultValue: false, description: 'Infrastructure creation')
        booleanParam(name: '_1_APPLICATION_DEPLOYMENT', defaultValue: false, description: 'Ansible Execution to deploy Application')
        string(name: 'private_key_location', defaultValue: '/tmp/application.pem', description: 'PrivateKey file store location which will be used by Ansible to do SSH ie., Upload Key file in this Location')
        choice(name: 'Environment', choices: 'DEV', description: 'Select Environment')
        choice(name: 'Action', choices: 'plan\napply\nplan-destroy\ndestroy', description: 'Select Terraform Action')
    }
    environment {
        TF_VAR_EC2_KEYPAIR_NAME = "${params.EC2_KEYPAIR_NAME}"
        private_key = "${params.private_key_location}"

    }
    stages {
        stage('Download Repositories') {
            steps {
                dir ('modules') {
                    checkout([
                        $class: 'GitSCM', branches: [[name: '*/master']],
                        extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'naveen_aws_core_module']],
                        userRemoteConfigs: [[url: 'https://github.com/naveencloud/naveen_aws_core_module.git']]
                    ])
                }
            }
        }
        stage('Application_Infra_Creation') {
			when { expression { params._1_MEDIAWIKI_INFRA == true } }
			steps {
				script {
					TerraApply("DEV", params.Environment, params.EC2_KEYPAIR_NAME, params.Action)
				}
			}
		}
        stage('Application_Deployment') {
            when { expression { params._1_APPLICATION_INFRA == true } }
            steps {
                script {
                    sh 'echo Establish Peering connection between Jenkins VPC and Newly Created VPC'
                }
            }
        }
        stage('Ansible_INSTALL_Application') {
            when { expression { params._1_APPLICATION_DEPLOYMENT == true } }
            steps {
                    dir('ansible') {
                        script {
                            sh 'pwd'
                            sh 'ansible-playbook -i env/aws/ec2.py plays/installapp.yml -e "host=tag_Environment_dev" -e ansible_ssh_user=ec2-user  -e ansible_ssh_private_key_file=/tmp/application.pem'
                        }
                    }
            }
        }
    }//stages
}//pipeline