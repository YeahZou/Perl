#!/user/bin/perl
# TechSure EZDeploy auto update script
# author  : Zou Ye
# Date    : 2018-09-02
# Version : V0.1

use strict;
use Getopt::Long;
use FindBin qw($Bin);
use JSON;
use Data::Dumper;
use Archive::Tar;
use Expect;

sub main {

}

# read conf update.conf, all update config is in it.
# format:
# [<host>]
# update_component=mysql,perl,jar
# user=xxx
# passwd=xxx
# ...
sub readConf {
    open( my $fh, "<", "$Bin/update.conf" ) or die "Can't open config file update.conf, $!\n";
    my %hostMap;
    my $host;
    while ( my $line = readline($fh) ) {
        if ( $line =~ m/\s*\[(.+)\]\s*/ ) {
            $host = $1;
            $hostMap{$host} = ();
        }
        elsif ( $line =~ m/\s*(\w+)\s*=\s*(.*)\s*/ ) {
            $hostMap{$host}{$1} = $2;
        }
    }

    #print(Dumper(\%hostMap));
    return \%hostMap;
}
#my $hostMap = readConf();
#print(Dumper($hostMap));
#print($hostMap->{'127.0.0.1'}->{'update_list'});

sub updatePerl {
    my $UPDATE_PATH = $Bin;
    my $BIN_PATH = $UPDATE_PATH . '/../bin';
    my $LIB_PATH = $UPDATE_PATH . '/../lib';

    my ($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
    my $timeStr = sprintf("%04d-%02d-%02d-%02d-%02d-%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
    #print($timeStr . "\n");
    system("tar -cvf $UPDATE_PATH/bin-$timeStr.tar $BIN_PATH") == 0 or die "tar backup $BIN_PATH failed, $?\n";
    system("tar -cvf $UPDATE_PATH/lib-$timeStr.tar $LIB_PATH") == 0 or die "tar backup $LIB_PATH failed, $?\n";

    system("tar -xvf $UPDATE_PATH/bin.tar -C $UPDATE_PATH/..") == 0 or die "tar update failed. $?\n";
    system("tar -xvf $UPDATE_PATH/lib.tar -C $UPDATE_PATH/..") == 0 or die "tar update lib.tar failed.\n";


}

sub scpUpdateFile {
    my $expect = Expect->new;
    my ($host, $user, $pwd) = @_;
    my $updatePath = $Bin;
    my $timeout = 1000;

    system("tar -cvf $updatePath.tar $updatePath") == 0 or die "tar $updatePath failed.\n";
    my $cmd = "scp $updatePath.tar $user\@$host:$updatePath\\..";

    my $spawnOK = 0;
    $expect->raw_pty(1);
    $expect->spawn($cmd) or die "Cannot spawn $cmd, $!\n";
    $expect->expect($timeout, [
	    qr'.+?continue connecting (yes/no)?'i,
	    sub {
	        my $self = shift;
		$self->send("yes\n");
		exp_continue;
	    }
	    ],
        [
	qr/$user@$host's password:/i,
	sub {
	    my $self = shift;
	    $self->send($pwd . "\n");
	    exp_continue;
	}
    ],[
        qr'lost connection'i,
	sub {
	    die "scp failed, pwd incorrect";
	}
    ],[
        timeout => sub {
	    die "scp failed, timeout.\n";
	}
    ]
);

}

updatePerl();
