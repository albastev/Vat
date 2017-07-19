#!perl6

use v6;
use Test;
use lib '../lib';
use Vat::Simple;

plan 10;

my $vat = Vat::Simple.new;
ok True;

my $supply = $vat.request_supply;

$supply.tap(-> $v {ok $v ~~ $vat.calculate_level});

$vat.tick;

$vat.fill(volume => 6, level => 100);

$vat.tick;

my $vat2 = Vat::Simple.new(volume => 100);
my $drained = $vat2.drain(level => 25, volume => 100);

ok $drained ~~ 75;

$vat2 = Vat::Simple.new(volume => 100);
$drained = $vat2.drain(level => 25, volume => 35);

ok $drained ~~ 35;

$vat2 = Vat::Simple.new(volume => 100);
my $vat3 = Vat::Simple.new(volume => 0);
my $vat4 = Vat::Simple.new(volume => 0);
my $poured-out = $vat2.drain(level => 75, volume => 26);

ok $poured-out ~~ 25;

my $poured-in = $vat3.fill(level=>20,volume=>$poured-out);

ok $poured-in ~~ 20;

$poured-in = $vat4.fill(level=>10,volume=>$vat3.drain(level=>15,volume=>150));

ok $poured-in ~~ 5;

my $left-over = $vat3.drain(level=>0,volume=>150);
ok $left-over ~~ 15;

$left-over = $vat2.drain(level=>0,volume=>150);
ok $left-over ~~ 75;



