my $file = "lsof.txt";

system("adb push lsof.sh /data/local/tmp");
system("adb shell sh /data/local/tmp/lsof.sh");
system ("adb pull /data/local/tmp/lsof.txt");

open(NODE, "<$file");	
while (<NODE>){
	my $line_raw = <NODE>;#`adb shell lsof | grep /dev/`; 
	#print "Avijit";
	#print $line_raw;
	my @lines = split('\n', $line_raw);
	#print "@lines";
	foreach(@lines){
		my $line = $_;
		#print $line;
		while(index($line, '  ') > 0){ 
			$line =~ s/  / /g; 
		}	 
		my @tokens = split(" ", $line);
		print("$tokens[8]\n");
	}
}
			