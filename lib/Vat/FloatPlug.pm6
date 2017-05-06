#!perl6

use v6;
use Vat::Attachment;

#closes when submerged
unit class Vat::FloatPlug does Vat::Attachment;

has method accepts_flow_in () {

  return False if self.submerged;
  
  True;
}

has method accepts_flow_out () {

  return False if self.submerged;
  
  True;
}
