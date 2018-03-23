# safe-etl
Example of ETL guaranteeing duplicate deletion and idempotency


## How to Debug

```
aws s3 cp sample.json <S3Uri>
```
s3://a-kimura-test/
```
digdag secrets --local --set td.apikey=xyzxyzxyzxyz
digdag secrets --local --set s3.access_key_id=xyzxyzxyzxyz
digdag secrets --local --set s3.secret_access_key=xyzxyzxyzxyz
```

```
cp env_debug.yml env_default.yml
```

```
digdag run safe_etl.dig --params-file 'env_default.yml'
```

