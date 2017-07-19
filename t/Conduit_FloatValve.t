#!perl6

use v6;
use Test;
use lib '../lib';

use Vat::Conduit;
use Vat::Simple;
use Vat::Hole;
use Vat::FloatValve;

plan 14;

my $conduit = Vat::Conduit.new;

my $vat1 = Vat::Simple.new(volume=>100);

my $vat2 = Vat::Simple.new(volume=>0);

my $attach1 = Vat::Hole.new(attachment_level => 0);

my $attach2 = Vat::FloatValve.new(attachment_level => 10);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$vat1.tick;
$vat2.tick;

ok $vat1.calculate_level ~~ 100;

ok $vat2.calculate_level ~~ 0;

nok $attach2.accepts_flow_in;

nok $attach2.accepts_flow_out;


for (1..15) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 100;

ok $vat2.calculate_level ~~ 0;

nok $attach2.accepts_flow_in;

nok $attach2.accepts_flow_out;

$vat2.fill(volume=>11, level=>100);

$vat1.tick;
$vat2.tick;

ok $attach2.accepts_flow_in;

ok $attach2.accepts_flow_out;


for (1..60) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 51;

ok $vat2.calculate_level ~~ 60;

ok $attach2.accepts_flow_in;

ok $attach2.accepts_flow_out;


