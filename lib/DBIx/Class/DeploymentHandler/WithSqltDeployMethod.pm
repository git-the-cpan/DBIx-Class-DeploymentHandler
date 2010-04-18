package DBIx::Class::DeploymentHandler::WithSqltDeployMethod;
BEGIN {
  $DBIx::Class::DeploymentHandler::WithSqltDeployMethod::VERSION = '0.001000_01';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::WithSqltDeployMethod::VERSION = '0.001000_01';
}
use Moose::Role;

# ABSTRACT: Delegate/Role for DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator

use DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator;

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

has sqltargs => (
  isa => 'HashRef',
  is  => 'ro',
  default => sub { {} },
);

sub _build_deploy_method {
  my $self = shift;
  DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator->new({
    schema            => $self->schema,
    databases         => $self->databases,
    upgrade_directory => $self->upgrade_directory,
    sqltargs          => $self->sqltargs,
  });
}

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::WithSqltDeployMethod - Delegate/Role for DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator

=head1 VERSION

version 0.001000_01

=head1 AUTHOR

  Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
