#!perl6

use v6;

use Vat;

unit class Vat:Histogram does Vat;

has Real $!maxLevel = 100;

has Real $!level = 0;

has Real $!volume = 0;

has Real $!scale = 1;

has @!histogram is default(1);

submethod BUILD( :$!volume = 0, :$!scale = 1, :@!histogram )
{
  self.calculate_level;
}

has method calculate_level () {
  my $lv = 0;
  my $vol = $!volume * 1;
  do while ($vol > 0)
  {
    my $level_volume = @!histogram[$lv];
    if $level_volume > $vol {
      $!level = $lv;
    }else{
      $vol -= $level_volume;
    }
    
    $lv++;
  }
  $!level = $lv;
  $lv * $!scale;
}
