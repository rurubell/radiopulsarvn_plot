#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Scalar::Util qw( looks_like_number );
use Encode qw(decode encode);
use Cwd 'abs_path';
use File::Basename;
use Term::ANSIColor;

binmode(STDOUT,':utf8');
binmode(STDIN,':utf8');


system( "libreoffice --headless --convert-to pdf *.odt" );
