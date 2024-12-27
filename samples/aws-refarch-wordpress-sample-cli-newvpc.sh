sam build --template ../templates/aws-refarch-wordpress-master-newvpc.yaml
sam deploy \
 --stack-name WordPress \
 --profile dev_partner \
 --template ../templates/aws-refarch-wordpress-master-newvpc.yaml \
 --s3-bucket mesrahub-dev \
 --s3-prefix WordPress \
 --capabilities CAPABILITY_IAM \
 --disable-rollback \
 --confirm-changeset \
 --use-json \
 --region ap-southeast-1 \
 --parameter-overrides \
    AdminEmail=info@mesrahub.my \
    AvailabilityZones=ap-southeast-1a,ap-southeast-1b,ap-southeast-1c \
    BastionInstanceType=t3.nano \
    CloudFrontAcmCertificate=arn:aws:acm:us-east-1:396913744197:certificate/d51625f7-59dc-4d56-b9e4-2606136133f3 \
    DatabaseCmk=- \
    DatabaseEncrpytedBoolean=true \
    DatabaseInstanceType=db.t3.medium \
    DatabaseMasterPassword=ChangeThisPassword1234 \
    DatabaseMasterUsername=DBWPAdmin \
    DatabaseName=databasename \
    EC2KeyName=my-key-pair \
    EfsAlarmsInstanceType=t3.nano \
    EfsCmk=arn:aws:kms:ap-southeast-1:396913744197:key/157a3d8b-73da-445b-a1e5-5a461713fa30 \
    EfsCreateAlarms=true \
    EfsCriticalThreshold=60 \
    EfsEncrpytedBoolean=true \
    EfsGrowth=0 \
    EfsGrowthInstanceType=r4.large \
    EfsPerformanceMode=generalPurpose \
    EfsWarningThreshold=180 \
    ElastiCacheNodeType=cache.t3.medium \
    NumberOfAZs=3 \
    PHPVersion=7.4 \
    PHPIniOverride=https=//s3.amazonaws.com/aws-refarch/wordpress/latest/bits/20-aws.ini \
    PublicAlbAcmCertificate=arn:aws:acm:ap-southeast-1:396913744197:certificate/32f23499-1389-4088-8e0b-bd53cc10bf80 \
    PublicSubnet0Cidr="10.0.200.0/24" \
    PublicSubnet1Cidr="10.0.201.0/24" \
    PublicSubnet2Cidr="10.0.202.0/24" \
    PublicSubnet3Cidr="10.0.203.0/24" \
    PublicSubnet4Cidr="10.0.204.0/24" \
    PublicSubnet5Cidr="10.0.205.0/24" \
    SshAccessCidr=0.0.0.0/0 \
    UseCloudFrontBoolean=true \
    UseElastiCacheBoolean=true \
    UseRoute53Boolean=true \
    VpcCidr="10.0.0.0/16" \
    VpcTenancy=default \
    WebAsgMax=4 \
    WebAsgMin=2 \
    WebInstanceType=t3.large \
    WebSubnet0Cidr="10.0.0.0/22" \
    WebSubnet1Cidr="10.0.4.0/22" \
    WebSubnet2Cidr="10.0.8.0/22" \
    WebSubnet3Cidr="10.0.12.0/22" \
    WebSubnet4Cidr="10.0.16.0/22" \
    WebSubnet5Cidr="10.0.20.0/22" \
    WPAdminPassword=ChangeThisPassword5678 \
    WPAdminUsername=WPAdmin \
    WPDirectory=SiteDirectory \
    WPDomainName=wordpress.dev.mesrahub.my \
    WPLocale=en_GB \
    WPTitle='This is a new WordPress site on Amazon Web Services' \
    WPVersion=latest 
 