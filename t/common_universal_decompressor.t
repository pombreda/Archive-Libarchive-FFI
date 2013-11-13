use strict;
use warnings;
use Archive::Libarchive::FFI qw( :all );
use Test::More tests => 3;
use FindBin ();
use File::Spec;

my $filename = File::Spec->catfile($FindBin::Bin, "foo.txt.gz.uu");

my $r;

my $a = archive_read_new();
archive_read_support_filter_all($a);
archive_read_support_format_raw($a);
$r = archive_read_open_filename($a, $filename, 16384);
is $r, ARCHIVE_OK;

$r = archive_read_next_header($a, my $ae);
is $r, ARCHIVE_OK;

my $buff;
while(1)
{
  my $size = archive_read_data($a, my $tmp, 1024);
  die archive_error_string($a) unless $size >= 0;
  last if $size == 0;
  $buff .= $tmp;
}

like $buff, qr{^Hello world$};

archive_read_free($a);
