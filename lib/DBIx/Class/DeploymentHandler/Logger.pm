package DBIx::Class::DeploymentHandler::Logger;
{
  $DBIx::Class::DeploymentHandler::Logger::VERSION = '0.002115';
}

use warnings;
use strict;

use parent 'Log::Contextual::WarnLogger';

# trace works the way we want it already

# sub is_trace {                  $_[0]->next::method }
sub is_debug { $_[0]->is_trace || $_[0]->next::method }
sub is_info  { $_[0]->is_debug || $_[0]->next::method }

sub is_warn  {
   my $orig = $_[0]->next::method;
   return undef if defined $orig && !$orig;
   return $_[0]->is_info || 1
}

sub is_error {
   my $orig = $_[0]->next::method;
   return undef if defined $orig && !$orig;
   return $_[0]->is_warn || 1
}

sub is_fatal {
   my $orig = $_[0]->next::method;
   return undef if defined $orig && !$orig;
   return $_[0]->is_error || 1
}

sub _log {
  my $self    = shift;
  my $level   = shift;
  my $message = join( "\n", @_ );
  $message .= "\n" unless $message =~ /\n$/;
  warn "[DBICDH] [$level] $message";
}

1;

__END__
=pod

=head1 NAME

DBIx::Class::DeploymentHandler::Logger

=head1 AUTHOR

Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

