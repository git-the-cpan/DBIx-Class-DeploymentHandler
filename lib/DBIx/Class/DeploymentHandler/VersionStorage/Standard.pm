package DBIx::Class::DeploymentHandler::VersionStorage::Standard;
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Standard::VERSION = '0.001000_01';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Standard::VERSION = '0.001000_01';
}
use Moose;

# ABSTRACT: Version storage that does the normal stuff

use Method::Signatures::Simple;

has schema => (
  isa      => 'DBIx::Class::Schema',
  is       => 'ro',
  required => 1,
);

has version_rs => (
  isa        => 'DBIx::Class::ResultSet',
  is         => 'ro',
  lazy_build => 1,
  handles    => [qw( database_version version_storage_is_installed )],
);

with 'DBIx::Class::DeploymentHandler::HandlesVersionStorage';

sub _build_version_rs {
  $_[0]->schema->register_class(
    __VERSION =>
      'DBIx::Class::DeploymentHandler::VersionStorage::Standard::VersionResult'
  );
  $_[0]->schema->resultset('__VERSION')
}

sub add_database_version { $_[0]->version_rs->create($_[1]) }

sub delete_database_version {
  $_[0]->version_rs->search({ version => $_[1]->{version}})->delete
}

__PACKAGE__->meta->make_immutable;

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::VersionStorage::Standard - Version storage that does the normal stuff

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

