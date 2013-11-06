while(1){
	$trinity_run = `adb shell ps | grep tri | wc -l`;
	print "$trinity_run";
	$slno = `adb get-serialno`;
	chomp($slno);
	$filename = $slno."_blacklist.txt";
	print ("$filename");
	$lines = 0;
    open(FILE, $filename) or die "Can't open `$filename': $!";
	while (<FILE>) {
    		$lines++;
	}
    close FILE;

	#Temporart hack
	$line--;
	print ("$trinity_run == $lines ");
	if ( $trinity_run == $lines ){
		print ("Device is running fine !!");
		sleep(1200);
	}
	else{
		print ("Need to stop the test...");
		exit(1);
		# As per design need to add the code
	}
}
