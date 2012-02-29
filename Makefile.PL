
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
    "DBD::SQLite" => "1.35",
    "DBIx::Class" => "0.08121",
    "File::Path" => "2.08",
    "File::Touch" => "0.08",
    "Log::Contextual" => "0.00300",
    "Moose" => "1.0",
    "MooseX::Role::Parameterized" => "0.18",
    "SQL::Translator" => "0.11005",
    "Test::Exception" => 0,
    "Test::More" => "0.88",
    "Test::Requires" => "0.06",
    "Try::Tiny" => 0,
    "aliased" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "parent" => "0.225"
  },
  "VERSION" => "0.002000",
  "test" => {
    "TESTS" => "t/*.t t/bugs/*.t t/deploy_methods/*.t t/version_handlers/*.t t/version_storages/*.t"
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



