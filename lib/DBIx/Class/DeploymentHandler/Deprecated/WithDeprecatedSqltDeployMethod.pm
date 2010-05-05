package DBIx::Class::DeploymentHandler::Deprecated::WithDeprecatedSqltDeployMethod;
BEGIN {
  $DBIx::Class::DeploymentHandler::Deprecated::WithDeprecatedSqltDeployMethod::VERSION = '0.001000_06';
}
use Moose::Role;

# ABSTRACT: (DEPRECATED) Use this if you are stuck in the past

use DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator::Deprecated;

has deploy_method => (
  does => 'DBIx::Class::DeploymentHandler::HandlesDeploy',
  is  => 'ro',
  lazy_build => 1,
  handles =>  'DBIx::Class::DeploymentHandler::HandlesDeploy',
);

has upgrade_directory => (
  isa      => 'Str',
  is       => 'ro',
  required => 1,
  default  => 'sql',
);

has databases => (
  coerce  => 1,
  isa     => 'DBIx::Class::DeploymentHandler::Databases',
  is      => 'ro',
  default => sub { [qw( MySQL SQLite PostgreSQL )] },
);

has sql_translator_args => (
  isa => 'HashRef',
  is  => 'ro',
  default => sub { {} },
);

sub _build_deploy_method {
  my $self = shift;
  DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator::Deprecated->new({
    schema              => $self->schema,
    databases           => $self->databases,
    upgrade_directory   => $self->upgrade_directory,
    sql_translator_args => $self->sql_translator_args,
  });
}

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::Deprecated::WithDeprecatedSqltDeployMethod - (DEPRECATED) Use this if you are stuck in the past

=head1 VERSION

version 0.001000_06

=head1 DEPRECATED

This component has been suplanted by
L<DBIx::Class::DeploymentHandler::WithSqltDeployMethod>.
In the next major version (1) we will begin issuing a warning on it's use.
In the major version after that (2) we will remove it entirely.

=head1 DELEGATION ROLE

This role is entirely for making delegation look like a role.  The actual
docs for the methods and attributes are at
L<DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator::Deprecated>

=head1 AUTHOR

  Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

