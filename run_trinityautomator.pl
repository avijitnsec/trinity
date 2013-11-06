my $file="supported_nodes.txt"; 
my $file1;
my $temp;
my $temp1;
my $flag=1;
my $device_check = "perl -w check_device.pl $$";
my $tmp_bl = "_blacklist.txt";
my $bl;
my $wl = "current_nodes.txt";
my $bl_tmp;
my $wl_tmp;
my $count = 0;
my $device;
my $serial;
my $pid = $$;
my $ct1; 
$us = "_";

@timeData = localtime(time);
my $ct1 = join('', @timeData);
chomp($ct1);

print "adb wait-for-device\n";
system("adb wait-for-device");

$serial = `adb get-serialno`;
chomp($serial);
$bl = join "", $serial, $us, $ct1, $us, $tmp_bl;
system("adb wait-for-device");
system("adb root");
system("adb wait-for-device");
system("adb remount");
system("adb wait-for-device");
system ("adb push trinity_target.sh \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\libs\\armeabi\\trinityexe \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\libs\\armeabi\\libqfast.so \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\libs\\armeabi\\libfuzzxmlparser.so \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\qfastconfig\\qfastfield_param.xml \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\qfastconfig\\qfastfield_grammar.xml \/data\/local\/tmp");
sleep 1;
print ("Current running PID: $pid");
system( "start cmd.exe /k $device_check $pid" );
while (1) {
	open FILE, "<$file" or die "Could not open $file: $!\n"; #$file means supported_nodes.txt
	@array=<FILE>;
	close FILE;
	$randomline=$array[rand @array];
	$temp = $randomline;
        $temp =~ s/\R//g;
	chomp ($temp);
	open (FL1, "<$bl");   #$bl is created out of all the running nodes 
	while(<FL1>){
		chomp;
		$bl_tmp = $_;
		if( $temp == $bl_tmp)
		{
			next;
		}
	}
	close(FL1);
	system("adb shell chmod 0777 /data/busybox/busybox");
	`adb shell    \"lsof | /data/busybox/busybox awk '{ print \$ \9 }' | grep /dev/\" >> current_nodes.txt`;
	open (FL2, "<$wl");
	while(<FL2>){
		chomp;
		$wl_tmp = $_;
		if( $temp == $wl_tmp)
		{
			next;
		}
	}
	close(FL2);
	print "Running trinity on $temp";
	open OUTFILE, ">>$bl"  or die "Error opening : $!";
	print OUTFILE $temp;
	print OUTFILE "/\n";
	close (OUTFILE);
	system("start cmd /k \"adb shell sh /data/local/tmp/trinity_target.sh $temp\"");
	sleep(60);
	$flag++;
	if ( $flag == 15){
		print ("Running 15 nodes..so terminating.. ");
		exit (1);
	}
	close(FILE);	
}
close(MYFILE);

