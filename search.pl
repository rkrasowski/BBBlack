#!/usr/bin/perl
use strict; 
use warnings;

my $result = checkSlots(2);
print "Result is $result\n";

sub checkSlots 
	{
		my $num = shift;		# num of tty we are looking for
		my $input_file = "/sys/devices/bone_capemgr.9/slots";
		open SLOTS, "<$input_file"  || die "Can't open $input_file: $!\n";





		while (<SLOTS>)
			{
				if ($_ =~ m/ttyO$num/)
					{
						return 7;
					}
			}
		close (SLOTS);
	}


