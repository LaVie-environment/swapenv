require 'aws-sdk-ec2'

AWS_ACCESS_KEY_ID = 'your-access-key'
AWS_SECRET_ACCESS_KEY = 'your-secret-key'

Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
})

ec2_conn = Aws::EC2::Client.new


require 'aws-sdk-ec2'

ec2_conn = Aws::EC2::Client.new(region: 'us-east-1')


require 'aws-sdk-ec2'

AWS_ACCESS_KEY_ID = 'your-access-key'
AWS_SECRET_ACCESS_KEY = 'your-secret-key'

Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
})

ec2_client = Aws::EC2::Client.new

# Create the security group
ssh_group = ec2_client.create_security_group({
  group_name: 'ssh',
  description: 'SSH access group'
})

# Authorize inbound SSH traffic
ec2_client.authorize_security_group_ingress({
  group_id: ssh_group.group_id,
  ip_protocol: 'tcp',
  from_port: 22,
  to_port: 22,
  cidr_ip: '0.0.0.0/0'
})

# Launch the EC2 instance
reservation = ec2_client.run_instances({
  image_id: 'ami-43a15f3e',
  instance_type: 't2.micro',
  key_name: 'your-key-pair-name',
  security_group_ids: [ssh_group.group_id]
})

# Get the instance object
instance = reservation.instances[0]
