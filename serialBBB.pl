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
# check if SLOT exist if no, crate it

my $SLOT1 = checkSlots(1);
if ($SLOT1 != 7)
	{
		print "Slot ttyO1 doesn't exist, will create it !!\n";		
		`echo ttyO1_armhf.com > /sys/devices/bone_capemgr.9/slots`;
	}
print "\nUART1 Tx set done....PIN (9_24)\n";
print "UART1 Rx set done....PIN (9_26)\n";


#set UART2
my $SLOT2 = checkSlots(2);
if ($SLOT2 != 7)
 	{
                print "Slot ttyO2 doesn't exist, will create it !!\n";
		`echo ttyO2_armhf.com > /sys/devices/bone_capemgr.9/slots`;
	}
print "\nUART2 Tx set done....PIN (9_21)\n";
print "UART2 Rx set done....PIN (9_22)\n";


#set UART4 
my $SLOT4 = checkSlots(4);
if ($SLOT4 != 7)
        {
		print "Slot ttyO4 doesn't exist, will create it !!\n";
		`echo ttyO4_armhf.com > /sys/devices/bone_capemgr.9/slots`;
	}
print "\nUART4 Tx set done....PIN (9_13)\n";
print "UART4 Rx set done....PIN (9_11)\n";




###########################################################################################


uart1();

########################################
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



sub uatr4 {
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


