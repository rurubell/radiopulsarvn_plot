#!/usr/bin/perl


use strict;
use warnings;
use utf8;


print( "Commit text: " );
my $s_commit_text = <STDIN>;

if( length( $s_commit_text ) <= 1 ) { $s_commit_text = "upd"; }

system( "git add ." );
system( "git commit -m \"" . $s_commit_text . "\" -a" );
system( "git status" );
system( "git push" );
