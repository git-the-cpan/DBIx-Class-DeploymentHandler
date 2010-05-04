package DBIx::Class::DeploymentHandler::VersionStorage::Standard::VersionResultSet;
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Standard::VersionResultSet::VERSION = '0.001000_05';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Standard::VersionResultSet::VERSION = '0.001000_05';
}

use strict;
use warnings;

use parent 'DBIx::Class::ResultSet';

use Try::Tiny;

sub version_storage_is_installed {
  my $self = shift;
  try { $self->next; 1 } catch { undef }
}

sub database_version {
  my $self = shift;
  $self->search(undef, {
    order_by => { -desc => 'id' },
    rows => 1
  })->get_column('version')->next;
}

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::VersionStorage::Standard::VersionResultSet

=head1 VERSION

version 0.001000_05

=head1 AUTHOR

  Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

