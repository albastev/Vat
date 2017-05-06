#!perl6

use v6;
use Vat::Attachment;

# allows bidirectional flow
unit class Vat::Hole does Vat::Attachment;

has method accepts_flow_in () {

  True;
}

has method accepts_flow_out () {

  True;
}
