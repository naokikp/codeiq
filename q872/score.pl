#!/usr/bin/perl
use strict;

my @f = glob 'q872_*.*';
while(my $f = shift @f){
    my(%d, $cnt);
    open my $fh, '<', $f or die;
    while(read $fh, my $ch, 1){
        $d{ord($ch)}=1;
        $cnt++;
    }
    my $n = scalar keys %d;
    printf "%-20s : %3d * %3d = %4d\n", $f, $cnt, $n, $cnt * $n;
}
