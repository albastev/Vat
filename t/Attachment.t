#!perl6

use v6;
use Test;
use lib '../lib';

plan 6;

use Vat::Hole; #simplest attachment

my $attachment = Vat::Hole.new(attachment_level => 15);

my $other = $attachment.update_level(0);

ok $other ~~ $attachment;

ok $attachment.submerged ~~ 0;

ok $attachment.update_level(50).submerged ~~ 35;

ok $attachment.update_level(14).submerged ~~ 0;

ok $attachment.update_level(15).submerged ~~ 0;

ok $attachment.update_level(16).submerged ~~ 1;
