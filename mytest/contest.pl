#perl -w
use DBI;

my $DSN = 'driver=Microsoft Access Driver (*.mdb);dbq=\\\\cheese\\g$\\perltest.mdb';
my $dbh = DBI->connect("dbi:ODBC:$DSN", '','') 
	or die "$DBI::errstr\n";


my %InfoTests = (
	'SQL_DRIVER_NAME', 6,
	'SQL_DRIVER_VER', 7,
	'SQL_CURSOR_COMMIT_BEHAVIOR', 23,
	'SQL_ALTER_TABLE', 86,
	'SQL_ACCESSIBLE_PROCEDURES', 20,
);

foreach $SQLInfo (sort keys %InfoTests) {
	$ret = 0;
	$ret = $dbh->func($InfoTests{$SQLInfo}, GetInfo);
	print "$SQLInfo ($InfoTests{$SQLInfo}):\t$ret\n";
}

$dbh->disconnect;
