#!/usr/bin/perl
use strict;
use Math::BigInt;
use LWP::Simple;

my $DB1MAX = Math::BigInt->new("1267650600228229401496703205376");
my $DB1TARGET = Math::BigInt->new("208050656559285601386927895421059705239114932023754");
my $DB2MAX = Math::BigInt->new("1267650600228229401496703205376");
my $DB2TARGET = Math::BigInt->new("2023636070998557444542586045");

my ($k1,$v1) = solve1(); print "DB1 : KEY = $k1, VALUE = $v1\n";
my ($k2,$v2) = solve2(); print "DB2 : KEY = $k2, VALUE = $v2\n";
exit;

sub solve1{
    my ($l,$r) = (0, $DB1MAX-1);
    while($l<=$r){
        my $c = ($l+$r)/2;
        my $resp = get("http://salvageon.textfile.org/?db=1&index=$c");
        my($d,$i,$k,$v) = split /\s+/, $resp;
        my $key = Math::BigInt->new(substr($k,1,length($k)-1));
        sleep 1;
        return ($k,$v) if($key == $DB1TARGET);
        if($key < $DB1TARGET){ $l = $c+1; } else { $r = $c-1; }
    }
    return 'none';
}

sub db2_key2index{
    my $n = shift;
    my $k = substr($n->as_bin, 2, length($n->as_bin)-2);    # 2進数化
    $k = "0"x(100-length($k)) . $k;                         # 100ビットに揃える
    $k =~ s/^([01]*)10*$/1\1/;                              # 末尾の1から後ろを削除し先頭に1を付ける
    return Math::BigInt->from_bin($k);                      # 10進数化
}

sub solve2{
    my $INDEX = db2_key2index($DB2TARGET);
    my $resp = get("http://salvageon.textfile.org/?db=2&index=$INDEX");
    my($d,$i,$k,$v) = split /\s+/, $resp;
    my $key = Math::BigInt->new(substr($k,1,length($k)-1));
    return ($k,$v) if($key == $DB2TARGET);
    return 'none';
}
