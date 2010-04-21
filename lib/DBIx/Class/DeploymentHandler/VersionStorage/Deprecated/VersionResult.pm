package DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResult;
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResult::VERSION = '0.001000_03';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResult::VERSION = '0.001000_03';
}

use strict;
use warnings;

use parent 'DBIx::Class::Core';

__PACKAGE__->table('dbix_class_schema_versions');

__PACKAGE__->add_columns (
   version => {
      data_type         => 'VARCHAR',
      is_nullable       => 0,
      size              => '10'
   },
   installed => {
      data_type         => 'VARCHAR',
      is_nullable       => 0,
      size              => '20'
   },
);

__PACKAGE__->set_primary_key('version');

__PACKAGE__->resultset_class('DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResultSet');

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::VersionStorage::Deprecated::VersionResult

=head1 VERSION

version 0.001000_03

=head1 AUTHOR

  Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

