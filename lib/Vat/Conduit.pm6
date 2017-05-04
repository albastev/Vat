#!perl6

use v6;
use Vat;
use Vat::Attachment;

unit class Vat::Conduit;

has @!attachments;

has method attach (Vat $vat, Vat::Attachment $attachment) {
  my $supply = $vat.request_supply;
  
  $supply.tap(-> $level { $attachment.update_level($level) });
  
  @!attachments.push($attachment);
}

has method tick () {
  # get submerged, sorted by level DESC
  # these are our sources
  
  # any that are not submerged are the preferred sinks
  
  # remove sources that are not valid outlets
  
  # remove sinks that are not valid inlets
  
  # transfer from sources to sinks, respecting capacity
}
