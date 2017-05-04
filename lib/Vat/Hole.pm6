#!perl6

use v6;

# allows bidirectional flow
unit class Vat::Hole does Vat::Attachment;

has method accepts_flow_in () {

  True;
}

has method accepts_flow_out () {

  True;
}
