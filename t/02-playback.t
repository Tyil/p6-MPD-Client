#! /usr/bin/env perl6

use v6.c;
use lib "lib";
use Test;

plan 2;

use MPD::Client;
use MPD::Client::Playback;
use MPD::Client::Status;

my $conn = mpd-connect(host => "localhost");

subtest "consume" => {
	plan 2;

	mpd-consume($conn, True);
	is mpd-status($conn)<consume>, True, "Consume state is set";

	mpd-consume($conn, False);
	is mpd-status($conn)<consume>, False, "Consume state is not set";
}

subtest "crossfade" => {
	plan 3;

	isa-ok mpd-crossfade($conn), "IO::Socket::INET", "crossfade returns the socket";

	mpd-crossfade($conn, 10);
	is mpd-status($conn)<xfade>, 10, "Check wether crossfade is applied properly";

	mpd-crossfade($conn);
	ok mpd-status($conn)<xfade>:!exists, "Check wether crossfade has been removed";
}