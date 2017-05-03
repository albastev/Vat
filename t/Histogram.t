#!perl6

use v6;
use Test;
use lib '../lib';
use Vat::Histogram;

plan 3;

my $vat = Vat::Histogram.new;
ok True;

my $vat2 = Vat::Histogram.new(volume => 100);
ok 100 ~~ $vat2.calculate_level;

my @histogram is default(1);
@histogram[0] = 51;

$vat2 = Vat::Histogram.new(volume => 100, histogram => @histogram);
ok 50 ~~ $vat2.calculate_level;

