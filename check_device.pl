my $temp = 1;
$ret = system("adb devices");
$us = "_";
$sl = `adb get-serialno`;
chomp ($sl);
@timeData = localtime(time);
$ct = join('', @timeData);
$fldr_nm = join "", $sl, $us, $ct;
my $pid = $ARGV[0];
$tmp = 1;
$flag;
$node = system("adb pull \/data\/local\/tmp\/current_node.txt .");
$file = "current_node.txt";
open (INPUT, "<$file");
while (<INPUT>){
		chomp;
		$temp = $_;
}
open OUTFILE, ">>test.txt"  or die "Error opening : $!";
close (OUTFILE);
for (;;){
	$tmp = 1;
	if(`adb get-state` =~ m/device/i) {
		if ($tmp == 1){
			open OUTFILE, ">>test.txt"  or die "Error opening : $!";
			print OUTFILE $temp;
			close (OUTFILE);
			$tmp=2;
		}
	}
	else {
		system ("start cmd /k \"perl -w terminate_script.pl $pid\"");
		exit(1);
	}
	sleep 1;
}