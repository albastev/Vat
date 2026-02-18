#!/usr/bin/env raku

use v6;
use Test;
use lib 'lib';

use Vat::Conduit;
use Vat::Simple;
use Vat::Hole;
use Vat::InletValve;

plan 16;

my $conduit = Vat::Conduit.new;

my $vat1 = Vat::Simple.new(volume=>100);

my $vat2 = Vat::Simple.new(volume=>0);

my $attach1 = Vat::Hole.new(attachment_level => 0);

my $attach2 = Vat::InletValve.new(attachment_level => 0);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$vat1.tick;
$vat2.tick;

ok $vat1.calculate_level ~~ 100;

ok $vat2.calculate_level ~~ 0;

ok $attach2.accepts_flow_in;

nok $attach2.accepts_flow_out;


for (1..15) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 85;

ok $vat2.calculate_level ~~ 15;

ok $attach2.accepts_flow_in;

nok $attach2.accepts_flow_out;

for (1..50) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 50;

ok $vat2.calculate_level ~~ 50;

ok $attach2.accepts_flow_in;

nok $attach2.accepts_flow_out;



$conduit = Vat::Conduit.new;

$vat1 = Vat::Simple.new(volume=>100);

$vat2 = Vat::Simple.new(volume=>0);

$attach1 = Vat::InletValve.new(attachment_level => 0);

$attach2 = Vat::Hole.new(attachment_level => 0);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$vat1.tick;
$vat2.tick;for (1..15) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 100;

ok $vat2.calculate_level ~~ 0;

ok $attach1.accepts_flow_in;

nok $attach1.accepts_flow_out;


