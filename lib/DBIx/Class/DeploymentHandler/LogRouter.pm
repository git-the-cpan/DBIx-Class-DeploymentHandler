package DBIx::Class::DeploymentHandler::LogRouter;
{
  $DBIx::Class::DeploymentHandler::LogRouter::VERSION = '0.002209';
}
use Moo;
use DBIx::Class::DeploymentHandler::Logger;

with 'Log::Contextual::Role::Router';

has _logger => (
   is      => 'lazy',
   builder => sub { DBIx::Class::DeploymentHandler::Logger->new },
);

sub handle_log_request {
   my ($self, %message_info) = @_;

   my $log_code_block = $message_info{message_sub};
   my $args           = $message_info{message_args};
   my $log_level_name = $message_info{message_level};
   my $logger         = $self->_logger;
   my $is_active      = $logger->can("is_${log_level_name}");

   return unless defined $is_active && $logger->$is_active;

   my $log_message = $log_code_block->(@$args);

   $self->_logger->$log_level_name($log_message);
}

sub before_import {}
sub after_import {}

1;

__END__

=pod

=head1 NAME

DBIx::Class::DeploymentHandler::LogRouter

=head1 AUTHOR

Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
