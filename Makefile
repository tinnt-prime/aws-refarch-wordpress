.DEFAULT_GOAL := help

ifndef SERIAL
$(error SERIAL is not set. Please use make with a 'SERIAL=xxx' argument.)
endif

ifeq ($(SERIAL),001)
CONFIG_PATH=./configs/.env_$(AWS_PROFILE)_$(SERIAL)
else
CONFIG_PATH=./configs/.env_$(AWS_PROFILE)_$(SERIAL)
endif

-include $(CONFIG_PATH)

## Show help.
help:
	@echo make deploy-vpc          				: Deploy vpc.
	@echo make deploy-securitygroups        	: Deploy security group.



confirm-env:
	@echo - - - - - - - - - - - - - - - -
	@echo AWS_PROFILE : $(AWS_PROFILE)
	@echo AWS_ACCOUNT_ID : $(AWS_ACCOUNT_ID)
	@echo AWS_REGION : $(AWS_REGION)
	@echo DEPLOY_ENV : $(DEPLOY_ENV)
	@echo SERIAL : $(SERIAL)
	@echo - - - - - - - - - - - - - - - -
	@read -p "Is it ok? (y/N): " ok; if [ -z $$ok ] || [ $$ok != "y" ]; then false; fi


deploy-master: confirm-env
	@echo "=== Deploy vpc stack. ==="
	sam build --template ./templates/aws-refarch-wordpress-master-newvpc.yaml
	sam deploy \
		--template ./templates/aws-refarch-wordpress-master-newvpc.yaml \
		--stack-name $(MASTER_STACK_NAME) \
		--s3-bucket $(AWS_S3_TEMPORARY_BUCKET_FOR_DEPLOY) \
		--s3-prefix $(MASTER_STACK_NAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--confirm-changeset \
		--parameter-overrides \
			AdminEmail=$(AdminEmail) \
			BastionInstanceType=$(BastionInstanceType) \
			CloudFrontAcmCertificate=$(CloudFrontAcmCertificate) \
			DatabaseCmk=$(DatabaseCmk) \
			DatabaseEncrpytedBoolean=$(DatabaseEncrpytedBoolean) \
			DatabaseInstanceType=$(DatabaseInstanceType) \
			DatabaseMasterUsername=$(DatabaseMasterUsername) \
			DatabaseMasterPassword=$(DatabaseMasterPassword) \
			DatabaseName=$(DatabaseName) \
			EC2KeyName=$(EC2KeyName) \
			EfsAlarmsInstanceType=$(EfsAlarmsInstanceType) \
			EfsCmk=$(EfsCmk) \
			EfsCreateAlarms=$(EfsCreateAlarms) \
			EfsCriticalThreshold=$(EfsCriticalThreshold) \
			EfsEncrpytedBoolean=$(EfsEncrpytedBoolean) \
			EfsGrowth=$(EfsGrowth) \
			EfsGrowthInstanceType=$(EfsGrowthInstanceType) \
			EfsPerformanceMode=$(EfsPerformanceMode) \
			EfsWarningThreshold=$(EfsWarningThreshold) \
			ElastiCacheNodeType=$(ElastiCacheNodeType) \
			PHPIniOverride=$(PHPIniOverride) \
			PHPVersion=$(PHPVersion) \
			PublicAlbAcmCertificate=$(PublicAlbAcmCertificate) \
			SshAccessCidr=$(SshAccessCidr) \
			UseCloudFrontBoolean=$(UseCloudFrontBoolean) \
			UseElastiCacheBoolean=$(UseElastiCacheBoolean) \
			UseRoute53Boolean=$(UseRoute53Boolean) \
			WebAsgMax=$(WebAsgMax) \
			WebAsgMin=$(WebAsgMin) \
			WebInstanceType=$(WebInstanceType) \
			WPAdminUsername=$(WPAdminUsername) \
			WPAdminPassword=$(WPAdminPassword) \
			WPDirectory=$(WPDirectory) \
			WPDomainName=$(WPDomainName) \
			WPLocale=$(WPLocale) \
			WPTitle=$(WPTitle) \
			WPVersion=$(WPVersion) \
			NumberOfAZs=$(NumberOfAZs) \
			AvailabilityZones=$(AvailabilityZones) \
			VpcCidr=$(VpcCidr) \
			VpcTenancy=$(VpcTenancy) \
			PublicSubnet0Cidr=$(PublicSubnet0Cidr) \
			PublicSubnet1Cidr=$(PublicSubnet1Cidr) \
			PublicSubnet2Cidr=$(PublicSubnet2Cidr) \
			PublicSubnet3Cidr=$(PublicSubnet3Cidr) \
			PublicSubnet4Cidr=$(PublicSubnet4Cidr) \
			PublicSubnet5Cidr=$(PublicSubnet5Cidr) \
			WebSubnet0Cidr=$(WebSubnet0Cidr) \
			WebSubnet1Cidr=$(WebSubnet1Cidr) \
			WebSubnet2Cidr=$(WebSubnet2Cidr) \
			WebSubnet3Cidr=$(WebSubnet3Cidr) \
			WebSubnet4Cidr=$(WebSubnet4Cidr) \
			WebSubnet5Cidr=$(WebSubnet5Cidr) \
			DataSubnet0Cidr=$(DataSubnet0Cidr) \
			DataSubnet1Cidr=$(DataSubnet1Cidr) \
			DataSubnet2Cidr=$(DataSubnet2Cidr) \
			DataSubnet3Cidr=$(DataSubnet3Cidr) \
			DataSubnet4Cidr=$(DataSubnet4Cidr) \
			DataSubnet5Cidr=$(DataSubnet5Cidr) \
		$(TAGS)

deploy-vpc: confirm-env
	@echo "=== Deploy vpc stack. ==="
	sam build --template ./templates/aws-refarch-wordpress-01-newvpc.yaml
	sam deploy \
		--template ./templates/aws-refarch-wordpress-01-newvpc.yaml \
		--stack-name $(VPC_STACK_NAME) \
		--s3-bucket $(AWS_S3_TEMPORARY_BUCKET_FOR_DEPLOY) \
		--s3-prefix $(VPC_STACK_NAME) \
		--capabilities CAPABILITY_IAM \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--confirm-changeset \
		--parameter-overrides \
			NumberOfAZs=$(NumberOfAZs) \
			AvailabilityZones=$(AvailabilityZones) \
			VpcCidr=$(VpcCidr) \
			VpcTenancy=$(VpcTenancy) \
			PublicSubnet0Cidr=$(PublicSubnet0Cidr) \
			PublicSubnet1Cidr=$(PublicSubnet1Cidr) \
			PublicSubnet2Cidr=$(PublicSubnet2Cidr) \
			PublicSubnet3Cidr=$(PublicSubnet3Cidr) \
			PublicSubnet4Cidr=$(PublicSubnet4Cidr) \
			PublicSubnet5Cidr=$(PublicSubnet5Cidr) \
			WebSubnet0Cidr=$(WebSubnet0Cidr) \
			WebSubnet1Cidr=$(WebSubnet1Cidr) \
			WebSubnet2Cidr=$(WebSubnet2Cidr) \
			WebSubnet3Cidr=$(WebSubnet3Cidr) \
			WebSubnet4Cidr=$(WebSubnet4Cidr) \
			WebSubnet5Cidr=$(WebSubnet5Cidr) \
			DataSubnet0Cidr=$(DataSubnet0Cidr) \
			DataSubnet1Cidr=$(DataSubnet1Cidr) \
			DataSubnet2Cidr=$(DataSubnet2Cidr) \
			DataSubnet3Cidr=$(DataSubnet3Cidr) \
			DataSubnet4Cidr=$(DataSubnet4Cidr) \
			DataSubnet5Cidr=$(DataSubnet5Cidr) \
		$(TAGS)

deploy-web: confirm-env
	@echo "=== Deploy web server stack. ==="
	sam build --template ./templates/aws-refarch-wordpress-04-web.yaml
	sam deploy \
		--template ./templates/aws-refarch-wordpress-04-web.yaml \
		--stack-name $(WEB_STACK_NAME) \
		--s3-bucket $(AWS_S3_TEMPORARY_BUCKET_FOR_DEPLOY) \
		--s3-prefix $(WEB_STACK_NAME) \
		--capabilities CAPABILITY_IAM \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--confirm-changeset \
		--parameter-overrides \
			PHPVersion=$(PHPVersion) \
			PHPIniOverride=$(PHPIniOverride) \
			EC2KeyName=$(EC2KeyName) \
			WebAsgMax=$(WebAsgMax) \
			WebAsgMin=$(WebAsgMin) \
			WebSecurityGroup=$(WebSecurityGroup) \
			NumberOfSubnets=$(NumberOfSubnets) \
			Subnet=$(Subnet) \
			PublicAlbTargetGroupArn=$(PublicAlbTargetGroupArn) \
			PublicAlbHostname=$(PublicAlbHostname) \
			SslCertificate=$(SslCertificate) \
			DatabaseClusterEndpointAddress=$(DatabaseClusterEndpointAddress) \
			DatabaseMasterUsername=$(DatabaseMasterUsername) \
			DatabaseMasterPassword=$(DatabaseMasterPassword) \
			DatabaseName=$(DatabaseName) \
			ElasticFileSystem=$(ElasticFileSystem) \
			WebInstanceType=$(WebInstanceType) \
			WPAdminEmail=$(AdminEmail) \
			WPAdminPassword=$(WPAdminPassword) \
			WPAdminUsername=$(WPAdminUsername) \
			WPDirectory=$(WPDirectory) \
			WPDomainName=$(WPDomainName) \
			WPLocale=$(WPLocale) \
			WPTitle=$(WPTitle) \
			WPVersion=$(WPVersion) \
		$(TAGS)

deploy-securitygroups: confirm-env
	@echo "=== Deploy securitygroups stack. ==="
	sam build --template ./templates/aws-refarch-wordpress-02-securitygroups.yaml
	sam deploy \
		--template ./templates/aws-refarch-wordpress-02-securitygroups.yaml \
		--stack-name $(SECURITYGROUPS_STACK_NAME) \
		--s3-bucket $(AWS_S3_TEMPORARY_BUCKET_FOR_DEPLOY) \
		--s3-prefix $(SECURITYGROUPS_STACK_NAME) \
		--capabilities CAPABILITY_IAM \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--confirm-changeset \
		--parameter-overrides \
			SshAccessCidr=$(SshAccessCidr) \
			Vpc=$(Vpc) \
		$(TAGS)

deploy-publicalb: confirm-env
	@echo "=== Deploy publicalb stack. ==="
	sam build --template ./templates/aws-refarch-wordpress-03-publicalb.yaml
	sam deploy \
		--template ./templates/aws-refarch-wordpress-03-publicalb.yaml \
		--stack-name $(PUBLICALB_STACK_NAME) \
		--s3-bucket $(AWS_S3_TEMPORARY_BUCKET_FOR_DEPLOY) \
		--s3-prefix $(PUBLICALB_STACK_NAME) \
		--capabilities CAPABILITY_IAM \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--confirm-changeset \
		--parameter-overrides \
			NumberOfSubnets=$(NumberOfSubnets) \
			PublicAlbAcmCertificate=$(PublicAlbAcmCertificate) \
			PublicAlbSecurityGroup=$(PublicAlbSecurityGroup) \
			Subnet=$(Subnet) \
			Vpc=$(Vpc) \
		$(TAGS)
