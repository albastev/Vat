#!perl6

use v6;

# opens when submerged
unit class Vat::FloatValve does Vat::Attachment;

has method accepts_flow_in () {

  return True if self.submerged;
  
  False;
}

has method accepts_flow_out () {

  return True if self.submerged;
  
  False;
}
