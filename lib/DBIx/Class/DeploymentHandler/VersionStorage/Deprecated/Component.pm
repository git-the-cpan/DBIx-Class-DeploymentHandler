package DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::Component;
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::Component::VERSION = '0.001000_02';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::Component::VERSION = '0.001000_02';
}

use strict;
use warnings;

use Carp 'carp';
use DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResult;

sub attach_version_storage {
   $_[0]->register_class(
      dbix_class_schema_versions => 'DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResult'
   );
}

sub connection  {
  my $self = shift;
  $self->next::method(@_);

  $self->attach_version_storage;

  my $args = $_[3] || {};

  unless ( $args->{ignore_version} || $ENV{DBIC_NO_VERSION_CHECK}) {
    my $versions = $self->resultset('dbix_class_schema_versions');

    if (!$versions->version_storage_is_installed) {
       carp "Your DB is currently unversioned. Please call upgrade on your schema to sync the DB.\n";
    } elsif ($versions->database_version ne $self->schema_version) {
      carp 'Versions out of sync. This is ' . $self->schema_version .
        ', your database contains version ' . $versions->database_version . ", please call upgrade on your Schema.\n";
    }
  }

  return $self;
}

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::Component

=head1 VERSION

version 0.001000_02

=head1 AUTHOR

  Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

