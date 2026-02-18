#!/usr/bin/env raku

use v6;
use Test;
use lib 'lib';

use Vat::Conduit;
use Vat::Simple;
use Vat::Hole;
use Vat::Valve;

plan 24;

my $conduit = Vat::Conduit.new;

my $vat1 = Vat::Simple.new(volume=>100);

my $vat2 = Vat::Simple.new(volume=>0);

my $attach1 = Vat::Valve.new(attachment_level => 0);

my $attach2 = Vat::Hole.new(attachment_level => 0);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$vat1.tick;
$vat2.tick;

ok $vat1.calculate_level ~~ 100;

ok $vat2.calculate_level ~~ 0;

nok $attach1.accepts_flow_in;

nok $attach1.accepts_flow_out;


for (1..15) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 100;

ok $vat2.calculate_level ~~ 0;

nok $attach1.accepts_flow_in;

nok $attach1.accepts_flow_out;

$attach1.open;

for (1..5) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 95;

ok $vat2.calculate_level ~~ 5;

ok $attach1.accepts_flow_in;

ok $attach1.accepts_flow_out;

$attach1.toggle;

for (6..10) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 95;

ok $vat2.calculate_level ~~ 5;

nok $attach1.accepts_flow_in;

nok $attach1.accepts_flow_out;

$attach1.toggle;

for (6..10) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 90;

ok $vat2.calculate_level ~~ 10;

ok $attach1.accepts_flow_in;

ok $attach1.accepts_flow_out;

$attach1.close;

for (11..15) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 90;

ok $vat2.calculate_level ~~ 10;

nok $attach1.accepts_flow_in;

nok $attach1.accepts_flow_out;


