#!/bin/bash
aws dynamodb list-tables --region us-west-2

#aws dynamodb put-item --table-name myDummyCollection --item  "" --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE --region us-west-2

aws dynamodb batch-write-item \
    --request-items file://collection.json \
    --return-consumed-capacity INDEXES \
    --return-item-collection-metrics SIZE \
    --region us-west-2

aws dynamodb scan --table-name myDummyCollection --region us-west-2