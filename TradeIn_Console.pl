use TradeIn;

my @isbns = qw( 978-0078034664 1118356470 978-0138000936 );

foreach( @isbns ) {
	my @test = getTradeInPrice( $_ );
	if (@test ) {
		print 'Selling for $' . $test[0] . ', ' . $test[1] . '(' . $test[1] . ")\n";
	}
}