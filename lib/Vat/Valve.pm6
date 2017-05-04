#!perl6

use v6;

# allows bidirectional flow
unit class Vat::Hole does Vat::Attachment;

has Bool $!open = False;

has method toggle () {
  $!open = !$!open;
  
  self;
}

has method open () {

  $!open = True;
  
  self;
}

has method close () {

  $!open = False;

  self;
}

has method is_open () {
  
  $!open;
}

has method accepts_flow_in () {

  $!open;
}

has method accepts_flow_out () {

  $!open;
}
