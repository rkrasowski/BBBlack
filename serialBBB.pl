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

#set UART1 
`echo ttyO1_armhf.com > /sys/devices/bone_capemgr.9/slots`;
print "\nUART1 Tx set done....PIN (9_24)\n";
print "UART1 Rx set done....PIN (9_26)\n";


#set UART4 
`echo ttyO4_armhf.com > /sys/devices/bone_capemgr.9/slots`;
print "\nUART4 Tx set done....PIN (9_13)\n";
print "UART4 Rx set done....PIN (9_11)\n";

###########################################################################################

# Activate serial connection for UART4, ttyO4:
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
                my $count_out = $ob1->write("Serial port test\n");
        }

while ( $serialData1 = <DEV> )
        {
                print"Serial data: $serialData1\n";
        }

undef $ob1;







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
		my $count_out = $ob4->write("Serial port test\n");
	}

while ( $serialData4 = <DEV> ) 
	{ 
		print"Serial data: $serialData4\n";								
	}

undef $ob4;
