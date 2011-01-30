#!/usr/local/bin/perl -w
use strict;
use Chart::Clicker;
use Chart::Clicker::Axis::DateTime;
use Chart::Clicker::Data::Series;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Renderer::Point;

my $cc = Chart::Clicker->new;
my $series = Chart::Clicker::Data::Series->new(
    values    => [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ],
    keys      => [
        1256042117, 1256148117, 1256149117, 1256150117, 1256151117, 1256152117,
        1256153117, 1250150117, 1256155117, 1256156117
    ],
);
my $ctx = $cc->get_context('default');
$ctx->domain_axis(Chart::Clicker::Axis::DateTime->new(position => 'bottom', orientation     => 'horizontal'));
my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series ]);
$cc->add_to_datasets($ds);
$cc->write_output('foo.png');
