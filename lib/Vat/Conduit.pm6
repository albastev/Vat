#!perl6

use v6;
use Vat;
use Vat::Attachment;

unit class Vat::Conduit;

has @!attachments;
has @!supplies;

has method attach (Vat $vat, Vat::Attachment $attachment) {
  my $supply = $vat.request_supply;
  
  $attachment.set_vat($vat);
  $supply.tap(-> $level { $attachment.update_level($level); });
  
  @!attachments.push($attachment);
  @!supplies.push($supply);
}

has method tick () {

  # get submerged, sorted by level DESC
  # these are our sources
  
  my @sorted = @!attachments.sort: {$^b.pressure <=> $^a.pressure};
  
  my $min = Inf;
  my $max = -Inf;
  
  @sorted.map(-> $v { 
    $v.tick;
    $min = $v.pressure if $v.pressure < $min;
    $max = $v.pressure if $v.pressure > $max; 
  });
  
  if $min ~~ $max  {return }; # equilibrium;
  if +@sorted ~~ 1 {return }; # nowhere to go
  
  my $top;
  my $bottom;
  
  repeat {
    @sorted = @sorted.sort: {$^b.pressure <=> $^a.pressure};
    $top = @sorted.shift();
    $bottom = @sorted.pop();
    
    next if $top.pressure - $bottom.pressure <= 1;
  
    next if $top.pressure ~~ 0;
    
    # do we need to replace the bottom?
    if !$bottom.accepts_flow_in || $bottom.capacity_remaining ~~ 0 {
      last if +@sorted ~~ 0;
      $bottom = @sorted.pop();
    }
    
    # do we need to replace the top?
    if !$top.accepts_flow_out || $top.capacity_remaining ~~ 0 {
      last if +@sorted ~~ 0;
      $top = @sorted.shift()
    }
        
    my $blorf = $top.flow_out(volume=>1,level=>$bottom.pressure);
    
    my $splorf = $bottom.flow_in(volume=>1,level=>$top.pressure);
    
    { $top.flow_in(volume=>1,level=>Inf); next; } if $splorf ~~ 0 and $blorf ~~ 1;
    
    next if $blorf < 1;
    
    @sorted.unshift($top);
    @sorted.push($bottom);
  
  } while +@sorted > 1;
  
  # any that are not submerged are the preferred sinks
  
  # remove sources that are not valid outlets
  
  # remove sinks that are not valid inlets
  
  # transfer from sources to sinks, respecting capacity
}
