#!perl6

use v6;

use Vat;

unit class Vat::Simple does Vat;

submethod BUILD( :$!volume = 0, :$!scale = 1, :$!maxLevel = 100 ) {
  self.calculate_level;
}

has method calculate_level () {

  my $lv = 0;
  my $vol = $!volume * 1;
  do while ($vol > 0)
  {
    my $level_volume = 1;
    if $level_volume > $vol {
      $!level = $lv;
      last;
    }else{
      $vol -= $level_volume;
    }
    $lv++;
  }
  $!level = $lv;
  $lv * $!scale;
}
