#!perl6

use v6;

# only lets flow out
unit class Vat::OutletValve does Vat::Attachment;

has method accepts_flow_in () {

  True;
}

has method accepts_flow_out () {

  False;
}
