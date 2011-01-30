
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Unix like streams, but with objects instead of lines of text',
  'AUTHOR' => 'Johan Lindstrom <johanl@cpan.org>',
  'BUILD_REQUIRES' => {
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'App-Pebble',
  'EXE_FILES' => [
    'bin/pebble.pl'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'App::Pebble',
  'PREREQ_PM' => {
    'Cache::FileCache' => '0',
    'Cache::NullCache' => '0',
    'Carp' => '0',
    'Chart::Clicker' => '0',
    'Chart::Clicker::Axis::DateTime' => '0',
    'Chart::Clicker::Data::DataSet' => '0',
    'Chart::Clicker::Data::Series' => '0',
    'Class::Autouse' => '2.00',
    'Data::Dumper' => '0',
    'Data::Format::Pretty::Console' => '0',
    'DateTime' => '0',
    'DateTime::Duration' => '0',
    'DateTime::Format::Duration' => '0',
    'DateTimeX::Easy' => '0',
    'Exporter' => '0',
    'File::HomeDir' => '0',
    'File::Slurp' => '0',
    'Format::Human::Bytes' => '0',
    'Getopt::Long' => '0',
    'IO::Pipeline' => '0',
    'JSON::XS' => '0',
    'LWP::UserAgent::WithCache' => '0',
    'List::MoreUtils' => '0',
    'List::Util' => '0',
    'Method::Signatures' => '0',
    'Moose' => '0',
    'MooseX::ClassAttribute' => '0',
    'Pebble::Object::Class' => '0',
    'Statistics::Descriptive' => '0',
    'Text::CSV_XS' => '0',
    'Time::Elapsed' => '0',
    'XML::LibXML' => '0',
    'XML::LibXML::XPathContext' => '0',
    'aliased' => '0'
  },
  'VERSION' => '0.003',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



