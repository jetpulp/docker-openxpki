if [ ! -f /.db_created ]
then
  openxpkiadm initdb -f && touch /.db_created
fi
if [ ! -f /etc/openxpki/ssl/ca-one/ca-root-1.crt ]
then
  /usr/share/doc/libopenxpki-perl/examples/sampleconfig.sh
  if [ -f /etc/sample_data ]
  then
    echo "WARNING"
    echo "WARNING"
    echo "WARNING"
    echo "Do not use default certificate for production"
  fi
fi

/etc/init.d/apache2 start
openxpkictl --foreground start
