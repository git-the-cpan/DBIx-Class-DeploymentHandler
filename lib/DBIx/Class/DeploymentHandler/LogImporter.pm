package DBIx::Class::DeploymentHandler::LogImporter;
{
  $DBIx::Class::DeploymentHandler::LogImporter::VERSION = '0.002205';
}

use warnings;
use strict;

use parent 'Log::Contextual';

use DBIx::Class::DeploymentHandler::Logger;

my $logger = DBIx::Class::DeploymentHandler::Logger->new({
   env_prefix => 'DBICDH'
});

sub arg_package_logger { $_[1] || $logger }

1;

__END__
=pod

=head1 NAME

DBIx::Class::DeploymentHandler::LogImporter

=head1 AUTHOR

Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

