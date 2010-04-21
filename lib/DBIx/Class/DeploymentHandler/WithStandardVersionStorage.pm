package DBIx::Class::DeploymentHandler::WithStandardVersionStorage;
BEGIN {
  $DBIx::Class::DeploymentHandler::WithStandardVersionStorage::VERSION = '0.001000_03';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::WithStandardVersionStorage::VERSION = '0.001000_03';
}
use Moose::Role;

# ABSTRACT: Delegate/Role for DBIx::Class::DeploymentHandler::VersionStorage::Standard

use DBIx::Class::DeploymentHandler::VersionStorage::Standard;

has version_storage => (
  does => 'DBIx::Class::DeploymentHandler::HandlesVersionStorage',
  is  => 'ro',
  builder => '_build_version_storage',
  handles =>  'DBIx::Class::DeploymentHandler::HandlesVersionStorage',
);

sub _build_version_storage {
  DBIx::Class::DeploymentHandler::VersionStorage::Standard
    ->new({ schema => $_[0]->schema });
}

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::WithStandardVersionStorage - Delegate/Role for DBIx::Class::DeploymentHandler::VersionStorage::Standard

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
