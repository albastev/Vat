#!perl6

use v6;
use Test;
use lib '../lib';

plan 16;

use Vat::OutletValve; # only allows flow out

my $attachment = Vat::OutletValve.new(attachment_level => 15);

my $other = $attachment.update_level(0);

ok $other ~~ $attachment;

ok $attachment.submerged ~~ 0;
nok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(50).submerged ~~ 35;
nok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(14).submerged ~~ 0;
nok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(15).submerged ~~ 0;
nok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(16).submerged ~~ 1;
nok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;
