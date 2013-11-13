use strict;
use warnings;
use Test::More;
use Archive::Libarchive::FFI;
BEGIN {
  plan skip_all => 'test requires YAML'
    unless eval q{ use YAML qw( Dump ); 1 };
  plan skip_all => 'test requires Archive::Libarchive::XS'
    unless eval q{ use Archive::Libarchive::XS; 1 };
  plan skip_all => 'test requires Test::Differences'
    unless eval q{ use Test::Differences; 1 };
};

plan tests => 2;

eq_or_diff(Dump($Archive::Libarchive::FFI::EXPORT_TAGS{const}), Dump($Archive::Libarchive::XS::EXPORT_TAGS{const}), "same constants");
eq_or_diff(Dump($Archive::Libarchive::FFI::EXPORT_TAGS{func}),  Dump($Archive::Libarchive::XS::EXPORT_TAGS{func}),  "same functions");

