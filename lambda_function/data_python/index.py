import boto3

region = 'us-east-1'
instances = ['i-0c9ff00448a8b1ba4', 'i-0f4e987f8de9951c5'] 

def stop_instances():
    ec2 = boto3.client('ec2', region_name=region)
    ec2.stop_instances(InstanceIds=instances)         
    print('Stopped your instances: ' + str(instances))

def start_instances():
    ec2 = boto3.client('ec2', region_name=region)   
    ec2.start_instances(InstanceIds=instances)     
    print('Started your instances: ' + str(instances))

def lambda_handler(event, context):
    action = event.get('action')
    if action == 'start':
        start_instances()
    elif action == 'stop':
        stop_instances()
    else:
        print('Invalid action specified')

    return {
        'statusCode': 200,
        'body': 'Operation completed successfully'
    }
