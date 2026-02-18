use v6;
use Vat::Attachment;

# only lets flow out
unit class Vat::OutletValve does Vat::Attachment;

has method accepts_flow_in () {

  False;
}

has method accepts_flow_out () {

  True;
}
