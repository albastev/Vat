#!/usr/bin/env raku

use v6;
use Test;
use lib 'lib';

use Vat::Conduit;
use Vat::Simple;
use Vat::Hole;

plan 1;

my $vat1 = Vat::Simple.new(volume=>50);

my $vat2 = Vat::Simple.new(volume=>50);


my $conduit1 = Vat::Conduit.new;

my $conduit2 = Vat::Conduit.new;


my $attach1 = Vat::Hole.new(attachment_level => 0,capacity => 5);

my $attach2 = Vat::Hole.new(attachment_level => 100,capacity => 5);


my $attach3 = Vat::Hole.new(attachment_level => 0,capacity => 5);

my $attach4 = Vat::Hole.new(attachment_level => 100,capacity => 5);

# establish flow from vat1 to vat2
$conduit1.attach($vat1,$attach1);

$conduit1.attach($vat2,$attach2);

# cycle back from vat1 to vat2
$conduit1.attach($vat2,$attach3);

$conduit1.attach($vat1,$attach4);

ok True;

# TODO: remember what this was supposed to be...
