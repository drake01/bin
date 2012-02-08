#!/usr/bin/perl


use strict;
use warnings;


my $temperature_path = '/sys/devices/virtual/hwmon/hwmon0/temp1_input';
my $critical_path    = '/sys/devices/virtual/hwmon/hwmon0/temp1_crit';

# No temperature information available.
if (! -e $temperature_path || ! -e $critical_path) {
    exit 1;
}

my $screen_mode = (defined $ARGV[0] and $ARGV[0] eq '-s');
my $tmux_mode   = (defined $ARGV[0] and $ARGV[0] eq '-t');

my $temperature;
my $critical;

my $file;
open $file, '<', $temperature_path or die $!;
$temperature = <$file>;
close $file;
open $file, '<', $critical_path or die $!;
$critical = <$file>;
close $file;

my $value = int($temperature / 1000);
my $risk  = ($critical - $temperature)/$critical;

# GNU screen mode with colors.
if ($screen_mode) {
    my $color;
    if ($risk < 0) {
        $color = 'br r'; # bold reverse
    } elsif ($risk < 0.1) {
        $color = 'b r';
    } elsif ($risk < 0.2) {
        $color = 'b y';
    } else {
        $color = 'b g';
    }

    print "\005{+$color}$value\005{-}\n";

# Same in tmux mode.
} elsif ($tmux_mode) {
    my $color;
    my $style = 'bold';
    if ($risk < 0) {
        $color = 'red';
        $style = 'reverse'; # blink doesn't work for me
    } elsif ($risk < 0.1) {
        $color = 'red';
    } elsif ($risk < 0.2) {
        $color = 'yellow';
    } else {
        $color = 'green';
    }

    print "#[fg=$color,$style]$value#[default]\n";

# Plain text output.
} else {
    print "$value\n";
}
