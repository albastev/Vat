#!/usr/bin/env raku

use v6;
use Test;
use lib 'lib';

use Vat::Conduit;
use Vat::Simple;
use Vat::Hole;

plan 5;

my $conduit = Vat::Conduit.new;

my $vat1 = Vat::Simple.new(volume=>5);

my $vat2 = Vat::Simple.new(volume=>0);

my $attach1 = Vat::Hole.new(attachment_level => 0,capacity => 5);

my $attach2 = Vat::Hole.new(attachment_level => 50,capacity => 5);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

ok 5 ~~ $attach1.capacity_remaining;

ok 5 ~~ $attach2.capacity_remaining;

$vat1.tick;
$vat2.tick;

ok True;

$conduit.tick;
$vat1.tick;
$vat2.tick;

say $vat1.calculate_level;
say $vat2.calculate_level;

ok $vat1.calculate_level ~~ 0;

ok $vat2.calculate_level ~~ 5;
