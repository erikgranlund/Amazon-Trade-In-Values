use v5.10;
use TradeIn;
use Text::CSV;

open INPUT, '<', 'ISBN.csv';
open OUTPUT, '>', 'Trade In Values.csv';

say OUTPUT 'ISBN, Price, Title, Amazon URL';

my $input_csv = new Text::CSV->new;
my $output_csv = new Text::CSV->new;

while( <INPUT> ) {
	$input_csv->parse($_);
	( $_ ) = $input_csv->fields();
	
	say 'Working on ' . $_;
	
	my @output = getTradeInPrice( $_ );
	$output_csv->combine( ( $_, @output ) );
	
	say OUTPUT $output_csv->string();
}

close INPUT;
close OUTPUT;