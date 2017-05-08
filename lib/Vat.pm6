#!perl6

use v6;

unit role Vat;

has Real $!maxLevel = 100;

has Real $!level = 0;

has Real $!volume = 0;

has Real $!scale = 1;

has Supplier $!supplier = Supplier.new;

has method calculate_level () {...}

has method drain (Real :$level, Real :$volume) {
  self.calculate_level;
  
  return 0 if $level > $!level;
  
  my $vol = $volume * 1;
  do while ( $vol > 0 ) 
  {
    last if $level >= $!level;
    $!volume--;
    self.calculate_level;
    $vol--;
  }
  
  $volume - $vol but True;
}

has method fill (Real :$level, Real :$volume) {
  self.calculate_level;
  return 0 if $level < $!level;
  
  my $vol = $volume * 1;
  do while ( $vol > 0 ) 
  {
    last if $level <= $!level;
    $!volume++;
    self.calculate_level;
    $vol--;
  }
  
  $volume - $vol but True;
}

has method request_supply () {

  $!supplier.Supply;
}

has method tick ( :$value ) {
  
  $!supplier.emit($!level);

  Nil;
}

has method level () {
  $!level;
}
