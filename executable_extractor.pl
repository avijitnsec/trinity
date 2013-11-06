my $files;

my $dir = $ARGV[0];
chdir($dir) or die "Cant chdir to $dir $!";
system("ls -lt");

`export PATH=$PATH:/local/mnt/workspace/TrinityAutomator/arm-linux-androideabi/bin`;
`ls *.c > ls.txt`;

open FILE, "<ls.txt" or die "Could not open the file ls.txt: $!\n";
while (<FILE>){
	chomp;
	my $tmp=$_;
	#my @tokens = split("/.c/", $tmp);
	#my @tokens = split /\Q./, $tmp;
	#my @tokens = split (//, $tmp);
	my( $v1, $v2 ) = unpack( 'a22 a2', $tmp );
	print ("$tmp ..... $v1\n");
	system("/local/mnt/workspace/TrinityAutomator/android-toolchain/bin/arm-linux-androideabi-gcc $tmp -o $v1");
} 
close FILE;
