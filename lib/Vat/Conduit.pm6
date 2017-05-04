#!perl6

use v6;
use Vat;

unit role Vat::Conduit;

has @!attachments;

has method attach (Vat $vat, Real $level, Real $capacity) {...}

has method !get_listener (Real $level, Real $capacity) {...}
