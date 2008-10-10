
#!perl
use Test::More;
use strict;
use warnings;

my $has_test_nowarnings = 1;
eval "require Test::NoWarnings";
$has_test_nowarnings = undef if $@;

END {
    Test::NoWarnings::had_no_warnings()
          if ($has_test_nowarnings);
}

my $basic_tests = 3;
my $tests = $basic_tests;
$tests += 1 if $has_test_nowarnings;
plan tests => $tests;
eval {
    require Test::Pod;
    Test::Pod->import;
};
SKIP: {
    if (($@) || ($Test::Pod::VERSION < '1.00')) {
        skip "Test::Pod 1.00 required for testing POD", $basic_tests;
    }
    my @pods = all_pod_files();
    foreach my $pod (@pods) {
        next if $pod !~ /(ODBC.pm)|(FAQ.pm)|(Changes.pm)/;
        pod_file_ok($pod);
    }
};
