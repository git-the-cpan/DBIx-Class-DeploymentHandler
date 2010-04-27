package DBIx::Class::DeploymentHandler::WithReasonableDefaults;
BEGIN {
  $DBIx::Class::DeploymentHandler::WithReasonableDefaults::VERSION = '0.001000_04';
}
BEGIN {
  $DBIx::Class::DeploymentHandler::WithReasonableDefaults::VERSION = '0.001000_04';
}
use Moose::Role;

# ABSTRACT: Make default arguments to a few methods sensible

requires qw( prepare_upgrade prepare_downgrade database_version schema_version );

around prepare_upgrade => sub {
  my $orig = shift;
  my $self = shift;

  my $from_version = shift || $self->database_version;
  my $to_version   = shift || $self->schema_version;
  my $version_set  = shift || [$from_version, $to_version];

  $self->$orig($from_version, $to_version, $version_set);
};


around prepare_downgrade => sub {
  my $orig = shift;
  my $self = shift;

  my $from_version = shift || $self->database_version;
  my $to_version   = shift || $self->schema_version;
  my $version_set  = shift || [$to_version, $from_version];

  $self->$orig($from_version, $to_version, $version_set);
};

around install_resultsource => sub {
  my $orig = shift;
  my $self = shift;
  my $source = shift;
  my $version = shift || $self->to_version;

  $self->$orig($source, $version);
};

1;



=pod

=head1 NAME

DBIx::Class::DeploymentHandler::WithReasonableDefaults - Make default arguments to a few methods sensible

=head1 VERSION

version 0.001000_04

=head1 AUTHOR

  Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

vim: ts=2 sw=2 expandtab
