#!perl6

use v6;
use Test;
use lib '../lib';

use Vat::Conduit;
use Vat::Simple;
use Vat::Hole;

plan 28;

my $conduit = Vat::Conduit.new;

my $vat1 = Vat::Simple.new(volume=>100);

my $vat2 = Vat::Simple.new(volume=>0);

my $attach1 = Vat::Hole.new(attachment_level => 0,capacity=>1);

my $attach2 = Vat::Hole.new(attachment_level => 10,capacity=>1);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$vat1.tick;
$vat2.tick;

ok True;

for (1..7) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 93;

ok $vat2.calculate_level ~~ 7;


for (8..14) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 86;

say $vat2.calculate_level;

ok $vat2.calculate_level ~~ 14;


for (15..18) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 82;

ok $vat2.calculate_level ~~ 18;


for (19..24) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 76;

ok $vat2.calculate_level ~~ 24;

for (25..60) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 45;

ok $vat2.calculate_level ~~ 55;



$conduit = Vat::Conduit.new;

$vat1 = Vat::Simple.new(volume=>99);

$vat2 = Vat::Simple.new(volume=>0);

$attach1 = Vat::Hole.new(attachment_level => 0);

$attach2 = Vat::Hole.new(attachment_level => 10);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$vat1.tick;
$vat2.tick;

for (1..56) {
  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
}

ok $vat1.calculate_level ~~ 45;

ok $vat2.calculate_level ~~ 54;

  $conduit.tick;
  $vat1.tick;
  $vat2.tick;

ok $vat1.calculate_level ~~ 45;

ok $vat2.calculate_level ~~ 54;



$conduit = Vat::Conduit.new;

$vat1 = Vat::Simple.new(volume=>99);

$vat2 = Vat::Simple.new(volume=>0);

my $vat3 = Vat::Simple.new(volume=>6);

$attach1 = Vat::Hole.new(attachment_level => 0);

$attach2 = Vat::Hole.new(attachment_level => 0);

my $attach3 = Vat::Hole.new(attachment_level => 0);

$conduit.attach($vat1,$attach1);

$conduit.attach($vat2,$attach2);

$conduit.attach($vat3,$attach3);


  $vat1.tick;
  $vat2.tick;
  $vat3.tick;
  
ok $vat1.calculate_level ~~ 99;

ok $vat2.calculate_level ~~ 0;

ok $vat3.calculate_level ~~ 6;

  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
  $vat3.tick;
  
ok $vat1.calculate_level ~~ 98;

ok $vat2.calculate_level ~~ 1;

ok $vat3.calculate_level ~~ 6;

  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
  $vat3.tick;
  
ok $vat1.calculate_level ~~ 97;

ok $vat2.calculate_level ~~ 2;

ok $vat3.calculate_level ~~ 6;

for (3..15) {

  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
  $vat3.tick;
}
  
ok $vat1.calculate_level ~~ 84;

ok $vat2.calculate_level + $vat3.calculate_level ~~ 105 - 84;

ok abs($vat2.calculate_level - $vat3.calculate_level) < 2;

for (16..70) {

  $conduit.tick;
  $vat1.tick;
  $vat2.tick;
  $vat3.tick;
}
  
ok $vat1.calculate_level ~~ 35;
ok $vat2.calculate_level ~~ 35;
ok $vat3.calculate_level ~~ 35;

