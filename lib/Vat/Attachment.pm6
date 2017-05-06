#!perl6

use v6;

unit role Vat::Attachment;

has Real $!attachment_level;

has Real $!capacity = 1;

has Real $!level;

has submethod BUILD ( :$!attachment_level, :$capacity = 1 ) {
  
}

has method update_level (Real $level) {
  
  $!level = $level;
  
  self;
}

has method submerged () {
  return $!level - $!attachment_level if $!attachment_level < $!level;
  
  return 0;
}

has method accepts_flow_in () {...}

has method accepts_flow_out () {...}


