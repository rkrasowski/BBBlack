#!/usr/bin/perl
use strict;
use warnings;
use Device::SerialPort;

############################################################### serialBBB.pl ####################################################################
#																		#	
#	Set pins for BBB and serial communication in multiple UARTS. Prerequisits: file in /lib/firmware with overlay. Must put is in $SLOTS	#	
#	echo  BB-UART1 > $SLOTS (without extension and version), check if it is there: cat $SLOTS						#
#	by Robert J. Krasowski 11/22/2013													#
#																		#
#################################################################################################################################################




###########################################################################################
#uart0();
uart4();
#uart2();
#uart1();
#uart5();
########################################

sub uart0 {
# Activate serial connection for UART1, ttyO1:
my $PORT0 = "/dev/ttyO0";
my $serialData0;

print "Starting UART0....\n";

my $ob0 = Device::SerialPort->new($PORT0) || die "Can't Open $PORT0: $!";

$ob0->baudrate(9600) || die "failed setting baudrate";
$ob0->parity("none") || die "failed setting parity";
$ob0->databits(8) || die "failed setting databits";
$ob0->handshake("none") || die "failed setting handshake";
$ob0->write_settings || die "no settings";
$| = 1;

open( DEV, "<$PORT0" ) || die "Cannot open $PORT0: $_";

while (1)
        {
                sleep(1);
                my $count_out = $ob0->write("Serial port test in UART0\n");
        }

while ( $serialData0 = <DEV> )
        {
                print"UART0: $serialData0\n";
        }

undef $ob0;
}






sub uart1 {
# Activate serial connection for UART1, ttyO1:
my $PORT1 = "/dev/ttyO1";
my $serialData1;

my $ob1 = Device::SerialPort->new($PORT1) || die "Can't Open $PORT1: $!";

$ob1->baudrate(9600) || die "failed setting baudrate";
$ob1->parity("none") || die "failed setting parity";
$ob1->databits(8) || die "failed setting databits";
$ob1->handshake("none") || die "failed setting handshake";
$ob1->write_settings || die "no settings";
$| = 1;

open( DEV, "<$PORT1" ) || die "Cannot open $PORT1: $_";

while (1)
        {
                sleep(1);
                my $count_out = $ob1->write("Serial port test in UART1\n");
        }

while ( $serialData1 = <DEV> )
        {
                print"UART1: $serialData1\n";
        }

undef $ob1;
}


sub uart2 {
# Activate serial connection for UART2, ttyO2:
my $PORT2 = "/dev/ttyO2";
my $serialData2;

my $ob2 = Device::SerialPort->new($PORT2) || die "Can't Open $PORT2: $!";

$ob2->baudrate(9600) || die "failed setting baudrate";
$ob2->parity("none") || die "failed setting parity";
$ob2->databits(8) || die "failed setting databits";
$ob2->handshake("none") || die "failed setting handshake";
$ob2->write_settings || die "no settings";
$| = 1;

open( DEV, "<$PORT2" ) || die "Cannot open $PORT2: $_";

while (1)
        {
                sleep(1);
                my $count_out = $ob2->write("Serial port test on UART2\n");
        }

while ( $serialData2 = <DEV> )
        {
                print"UART2: $serialData2\n";
        }

undef $ob2;

}



sub uart4 {
# Activate serial connection for UART4, ttyO4:
my $PORT4 = "/dev/ttyO4"; 
my $serialData4;

my $ob4 = Device::SerialPort->new($PORT4) || die "Can't Open $PORT4: $!";

$ob4->baudrate(9600) || die "failed setting baudrate";
$ob4->parity("none") || die "failed setting parity";
$ob4->databits(8) || die "failed setting databits";
$ob4->handshake("none") || die "failed setting handshake";
$ob4->write_settings || die "no settings";
$| = 1;

open( DEV, "<$PORT4" ) || die "Cannot open $PORT4: $_";

while (1)
	{
		sleep(1);
		my $count_out = $ob4->write("Serial port test on UART4\n");
	}

while ( $serialData4 = <DEV> ) 
	{ 
		print"UART4: $serialData4\n";								
	}

undef $ob4;

}




sub uart5 {
# Activate serial connection for UART5, ttyO5:

print "Starting UART5\n";

my $PORT5 = "/dev/ttyO5";
my $serialData5;

my $ob5 = Device::SerialPort->new($PORT5) || die "Can't Open $PORT5: $!";

$ob5->baudrate(9600) || die "failed setting baudrate";
$ob5->parity("none") || die "failed setting parity";
$ob5->databits(8) || die "failed setting databits";
$ob5->handshake("none") || die "failed setting handshake";
$ob5->write_settings || die "no settings";
$| = 1;

open( DEV, "<$PORT5" ) || die "Cannot open $PORT5: $_";

while (1)
        {
                sleep(1);
                my $count_out = $ob5->write("Serial port test on UART5\n");
        }

while ( $serialData5 = <DEV> )
        {
                print"UART5: $serialData5\n";
        }

undef $ob5;

}




################################################## Subroutines #############################

# check if SLOTS exist 
sub checkSlots 
        {
                my $num = shift;                # num of tty we are looking for
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


