package DBIx::Class::DeploymentHandler::Types;
BEGIN {
  $DBIx::Class::DeploymentHandler::Types::VERSION = '0.001001';
}
use strict;
use warnings;

# ABSTRACT: Types internal to DBIx::Class::DeploymentHandler

use Moose::Util::TypeConstraints;
subtype 'DBIx::Class::DeploymentHandler::Databases'
 => as 'ArrayRef[Str]';

coerce 'DBIx::Class::DeploymentHandler::Databases'
 => from 'Str'
 => via { [$_] };
no Moose::Util::TypeConstraints;

1;

# vim: ts=2 sw=2 expandtab



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::Types - Types internal to DBIx::Class::DeploymentHandler

=head1 AUTHOR

Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

