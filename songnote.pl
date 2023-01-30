#!/usr/bin/env perl

use strict;
use warnings;

use lib 'local/lib/perl5';
use File::Basename;
use Path::Tiny;
use YAML;
use Template;

my $input = $ARGV[0];
if(!defined($input) || !-f $input) {
    die("Usage: $0 INPUT");
}

my $songData = YAML::LoadFile($input);

my $tt = Template->new({
    INCLUDE_PATH => './templates',
}) or die($!);

my $output = path("output", basename($input));
$output =~ s/\.ya?ml$/.html/i;


my $result = $tt->process('song.tt2', $songData, $output) || die $tt->error(), "\n";
