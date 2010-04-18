package DBIx::Class::DeploymentHandler::WithExplicitVersions;
BEGIN {
  $DBIx::Class::DeploymentHandler::WithExplicitVersions::VERSION = '0.001000_01';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::WithExplicitVersions::VERSION = '0.001000_01';
}
use Moose::Role;

# ABSTRACT: Delegate/Role for DBIx::Class::DeploymentHandler::VersionHandler::ExplicitVersions

use DBIx::Class::DeploymentHandler::VersionHandler::ExplicitVersions;

use Carp 'carp';

has version_handler => (
  is         => 'ro',
  lazy_build => 1,
  does       => 'DBIx::Class::DeploymentHandler::HandlesVersioning',
  handles    => 'DBIx::Class::DeploymentHandler::HandlesVersioning',
);

sub _build_version_handler {
  my $self = shift;

  my $args = {
    database_version => $self->database_version,
    schema_version   => $self->schema_version,
  };

  $args->{to_version} = $self->to_version if $self->has_to_version;
  DBIx::Class::DeploymentHandler::VersionHandler::ExplicitVersions->new($args);
}

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::WithExplicitVersions - Delegate/Role for DBIx::Class::DeploymentHandler::VersionHandler::ExplicitVersions

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

