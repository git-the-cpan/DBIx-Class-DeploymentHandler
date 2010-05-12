
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t t/deploy_methods/*.t t/version_handlers/*.t t/version_storages/*.t'
                                 },
                       'NAME' => 'DBIx::Class::DeploymentHandler',
                       'DISTNAME' => 'DBIx-Class-DeploymentHandler',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Extensible DBIx::Class deployment',
                       'EXE_FILES' => [],
                       'VERSION' => '0.001000_08',
                       'PREREQ_PM' => {
                                        'DBD::SQLite' => '0',
                                        'File::Touch' => '0.08',
                                        'aliased' => '0',
                                        'autodie' => '0',
                                        'File::Path' => '2.08',
                                        'DBIx::Class' => '0.08121',
                                        'Moose' => '1.0',
                                        'Try::Tiny' => '0',
                                        'namespace::autoclean' => '0',
                                        'SQL::Translator' => '0.11005',
                                        'Test::Exception' => '0',
                                        'Method::Signatures::Simple' => '0.05',
                                        'Carp' => '0',
                                        'Test::More' => '0.88',
                                        'Carp::Clan' => '0',
                                        'MooseX::Role::Parameterized' => '0.18'
                                      },
                       'LICENSE' => 'perl'
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



