import json
import random
import boto3

PARTITION_KEY_PREFIX = os.environ["PARTITION_KEY_PREFIX"]

def lambda_handler(event, context):
    records = event["records"]
    
    output_records = []
    for record in records:
        data = json.loads(record["data"])
        
        partition_key = f"{PARTITION_KEY_PREFIX}-{random.randint(1, 10)}"
        
        output_record = {
            "recordId": record["recordId"],
            "result": "Ok",
            "data": json.dumps(data),
            "partitionKey": partition_key
        }
        
        output_records.append(output_record)
    
    return {"records": output_records}
