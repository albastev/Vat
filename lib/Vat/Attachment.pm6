#!perl6

use v6;
use Vat;

unit role Vat::Attachment;

has Real $!attachment_level;

has Real $!capacity = 1;

has Real $!capacity_used = 0;

has Real $!level;

has Vat $!vat;

has submethod BUILD ( :$!attachment_level, :$capacity = 1 ) {
  
}

has method set_vat (Vat $vat) {
  $!vat = $vat;
}

has method update_level (Real $level) {
  
  $!level = $level;
  
  self;
}

has method submerged () {

  return $!level - $!attachment_level if $!attachment_level < $!level;
  
  0;
}

has method accepts_flow_in () {...}

has method accepts_flow_out () {...}

has method capacity () {

  $!capacity;
}

has method flow_in (:$volume = 1, :$level = 100) {
  
  return False if $!capacity_used >= $!capacity;
  
  my $ret = $!vat.fill(volume => $volume, level => $level);
  
  $!capacity_used += $volume;
  $ret;
}

has method flow_out (:$volume = 1,:$level = 0) {

  return False if $!capacity_used <= - $!capacity;
  
  my $ret = $!vat.drain(volume => $volume, level => $level);

  $!capacity_used -= $volume;
  $ret;
}

has method capacity_remaining () {
  
  $!capacity - $!capacity_used.abs;
}

has method tick () {
  $!capacity_used = 0;
}

has method pressure () {
  $!vat.level;
}


