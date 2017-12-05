##############################################################################
#
# File  :   <unix-shell>:tsung_examples/running_examples.sh
# Author:   Andreas.Peters@peddy.net
# Date  :   05.12.2017
# Subj. :   shell-script to load dockercontainer and run tsung-examples
#
##############################################################################
TSUNG_TESTS="
	tsung_example_simple1_singel_http.xml
	tsung_example_simple2_multiple_http.xml
	tsung_example_simple3_ssl.xml
	tsung_example_simple4_useragents.xml
	tsung_example_simple5_thinktime.xml
	tsung_example_simple6_request_statements.xml
	tsung_example_simple7_transactions.xml
	tsung_example_dyn_variable.xml
"
HTDOCS=/usr/local/apache2/htdocs/

## START-Zielmaschine
echo "============= Starting dockercontainer with apache-httpd"
docker run -d --name tsungwebhost -p 11080:80  -p11443:443 httpd:2.4-alpine

echo "============= wait two seconds for starting httpd in dockercontainer and then launch showing logs as a backgroudprozess"; sleep 2
docker logs tsungwebhost --follow &

echo "============= copy testfiles"
for f in htdocs/*; do docker cp $f tsungwebhost:$HTDOCS/; done

echo "============= simple standard HTTP-request, to see, showing logs is working"
curl http://localhost:11080/


##echo "============= simple standard HTTPS-request, to see, showing logs is working"
##curl -k https://localhost:11443/



echo "============= Starte TSUNG-Tests ============="
for t in $TSUNG_TESTS; do
	echo "============= running:"; set -x
	tsung -k -f "$t"  start
	set +x
	echo "start next TSUNG_TEST? (Y/N)"
	read userinput
	if [ "$userinput" == "y" -o "$userinput" == "Y" ]
		then echo " continue ..."
		else break
	fi
done



echo "============= TEST-END: stopping and remowing dockercontainer"
docker stop tsungwebhost
docker rm tsungwebhost


### EOF ###
