#!/usr/bin/env raku

use v6;
use Test;
use lib 'lib';

plan 22;

use Vat::Valve; #Toggle open state

my $attachment = Vat::Valve.new(attachment_level => 15);

nok $attachment.is_open;

ok $attachment.open.is_open;

nok $attachment.close.is_open;

ok $attachment.toggle.is_open;

nok $attachment.toggle.is_open;

ok $attachment.open.is_open;

my $other = $attachment.update_level(0);

ok $other ~~ $attachment;

ok $attachment.submerged ~~ 0;
ok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(50).submerged ~~ 35;
ok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(14).submerged ~~ 0;
ok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(15).submerged ~~ 0;
ok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;

ok $attachment.update_level(16).submerged ~~ 1;
ok $attachment.accepts_flow_in;
ok $attachment.accepts_flow_out;
