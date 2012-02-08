#!/usr/bin/perl


use strict;
use warnings;


my $path = '/sys/class/power_supply/BAT0/uevent';

# No battery available.
if (! -e $path) {
    exit 1;
}

my $screen_mode = (defined $ARGV[0] and $ARGV[0] eq '-s');
my $tmux_mode   = (defined $ARGV[0] and $ARGV[0] eq '-t');

my %battery;

open my $file, '<', $path or die $!;
while (<$file>) {
    /^POWER_SUPPLY_([A-Z_]+)=(.+)$/;
    $battery{$1} = $2;
}
close $file;

my $charge = int($battery{CHARGE_NOW} / $battery{CHARGE_FULL} * 100);

# GNU screen mode with colors: 0-20 red, 20-40 yellow, 40-100 green.
if ($screen_mode) {
    my $color;
    if ($charge < 20) {
        $color = 'b r';
    } elsif ($charge < 40) {
        $color = 'b y';
    } else {
        $color = 'b g';
    }

    print "\005{+$color}$charge%\005{-}\n";

# Same in tmux mode.
} elsif ($tmux_mode) {
    my $color;
    if ($charge < 20) {
        $color = 'red';
    } elsif ($charge < 40) {
        $color = 'yellow';
    } else {
        $color = 'green';
    }

    print "#[fg=$color,bold]$charge%#[default]\n";

# Plain text output.
} else {
    print "$charge%\n";
}
