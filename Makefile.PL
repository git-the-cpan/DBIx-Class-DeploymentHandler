
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Extensible DBIx::Class deployment",
  "AUTHOR" => "Arthur Axel \"fREW\" Schmidt <frioux+cpan\@gmail.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "DBIx-Class-DeploymentHandler",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "DBIx::Class::DeploymentHandler",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Carp::Clan" => 0,
    "Context::Preserve" => "0.01",
    "DBIx::Class" => "0.08121",
    "Log::Contextual" => "0.005005",
    "Moo" => "1.003",
    "Moose" => 1,
    "MooseX::Role::Parameterized" => "0.18",
    "Path::Class" => "0.26",
    "SQL::Translator" => "0.11005",
    "Sub::Exporter::Progressive" => 0,
    "Text::Brew" => "0.02",
    "Try::Tiny" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "parent" => "0.225"
  },
  "TEST_REQUIRES" => {
    "DBD::SQLite" => "1.35",
    "File::Temp" => 0,
    "Test::Fatal" => "0.006",
    "Test::More" => "0.88",
    "Test::Requires" => "0.06",
    "aliased" => 0
  },
  "VERSION" => "0.002208",
  "test" => {
    "TESTS" => "t/*.t t/bugs/*.t t/deploy_methods/*.t t/version_handlers/*.t t/version_storages/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

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



