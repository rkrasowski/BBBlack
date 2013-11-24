#!/usr/bin/perl

use strict;
use warnings;
use Device::SerialPort;

# set pins in appropriate modes:
# Set UART 2
# Set Tx pin



`echo ttyO2_armhf.com > /sys/devices/bone_capemgr.9/slots`;


print "UART2 Tx set done....PIN 21\n";

print "UART2 Rx set done....PIN 22\n";

# Activate serial connection:
my $PORT = "/dev/ttyO2"; 
my $serialData;

my $ob = Device::SerialPort->new($PORT) || die "Can't Open $PORT: $!";

$ob->baudrate(9600) || die "failed setting baudrate";
$ob->parity("none") || die "failed setting parity";
$ob->databits(8) || die "failed setting databits";
$ob->handshake("none") || die "failed setting handshake";
$ob->write_settings || die "no settings";
$| = 1;



open( DEV, "<$PORT" ) || die "Cannot open $PORT: $_";




#while (1){
#sleep(1);
#my $count_out = $ob->write("Serial port test\n");
#}



while ( $serialData = <DEV> ) { 
	
	
	
	print"Serial data: $serialData\n";
	
										

}

 undef $ob;
