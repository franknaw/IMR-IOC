
#### Generate Token - LOGIN 
- POST
- https://sandbox-train.foosource.net/guacamole/api/tokens
- Body: urlencoded
```angular2html
 username=someuser 
 password=thepass
```

- Response
```json
{
    "authToken": "54B8F11C1DDEFA0690A92CB5E757454F28D5BE57F3DAC4807888657B59B8F9AA",
    "username": "someuser",
    "dataSource": "postgresql",
    "availableDataSources": [
        "postgresql",
        "postgresql-shared"
    ]
}
```

#### Delete Token 
- DELETE
```
https://sandbox-train.foosource.net/guacamole/api/tokens/24EB99465AA4E2B51C8966D9FE33E00508E6DF7E507F41FA8A574801383D0D1A
```
- Response `1`
