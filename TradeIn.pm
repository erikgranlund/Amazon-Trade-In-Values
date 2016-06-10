package TradeIn;
use strict;
use warnings;
use Exporter;

use LWP::Simple;
use WWW::Scraper::ISBN::AmazonUS_Driver;

our @ISA= qw( Exporter );

# these CAN be exported.
our @EXPORT_OK = qw( getTradeInPrice );

# these are exported by default.
our @EXPORT = @EXPORT_OK;

sub getTradeInPrice {
	my ( $isbn ) = @_;
	
	# Attempt to find the item on Amazon by searching using the ISBN
	my $driver = WWW::Scraper::ISBN::AmazonUS_Driver->new();
	$driver->search($isbn);
	
	if ($driver->found) {
		my $url = $driver->book()->{'book_link'};
		my $title = $driver->book()->{'title'};
		
		# For some reason the title has author information as well as a bunch of other crap - cut it out
		$title =~ s/ \[.*$//s;
		
		my $response = LWP::Simple::get ($url);
	
		if( $response =~ /For a.*>\$(\d*\.\d*)/ ) {
			my $price = $1;
			return ($price, $title, $url );
		} else {
			return ('0', $title, $url);
		}
	} else {
		return ( '0', "No Amazon Record for $isbn", '' );
	}
}