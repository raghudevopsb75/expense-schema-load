source /config/params

git clone https://github.com/raghudevopsb75/${COMPONENT}
cd $COMPONENT/schema
if [ -n "$DOCDB_ENDPOINT" ]; then
  curl -L -o /tmp/global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
  mongo --ssl --host $DOCDB_ENDPOINT:27017 --sslCAFile /tmp/global-bundle.pem --username $DOCDB_USERNAME --password $DOCDB_PASSWORD <$COMPONENT.js
fi

if [ -n "$RDS_ENDPOINT" ]; then
  mysql -h${RDS_ENDPOINT} -u${RDS_USER} -p${RDS_PASS} <${COMPONENT}.sql
fi

