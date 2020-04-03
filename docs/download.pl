#!/usr/bin/perl -w

use v5.18;

open(my $IN, 'CRYPTOGRAPHY.md') or die("Can't read CRYPTOGRAPHY.md");
binmode($IN);

while (!eof($IN)) {
    my $line = <$IN>;

    if ($line =~ m/\[([-\w]+)\]\((https:\/\/latex.+)\)/o) {
        my $cmd = "curl -sSL '$2' -o $1.png";
        say $cmd;
    }
}


close(IN);
