<?php
	date_default_timezone_set ('Europe/Berlin');
	$cookievalue="";
	echo "<h1>test_me2.php</h1>";

	if (empty($_COOKIE["pedtest_test_me2"])) {
   		echo "Cookie 'pedtest_test_me2' ist bisher nicht gesetzt oder gefüllt!<br>";
		$cookievalue=date("Y-m-d-H:i:s");
	}
	else {
		echo "<h2>ursprünglich gesetzter Cookiewert:</h2>";
		$cookievalue=$_COOKIE["pedtest_test_me2"];
		echo $_COOKIE["pedtest_test_me2"];
		print_r($_COOKIE);
		$fh = fopen('php://stdout','w');
#		fwrite($fh, "========== Cookie:".$_COOKIE["pedtest_test_me2"]."\n");
		fwrite($fh, "__________ Cookie:".print_r($_COOKIE,true)."\n");
	}

	echo "<h2>zu setzender Cookiewert ist: ${cookievalue}</h2>";
	setcookie( "pedtest_test_me2", $cookievalue, strtotime( '+2 minutes' ) );

	echo "<br><br><hr>### EOF ###";
?>
