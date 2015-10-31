package DBIx::Class::DeploymentHandler;
$DBIx::Class::DeploymentHandler::VERSION = '0.002218';
# ABSTRACT: Extensible DBIx::Class deployment

use Moose;

extends 'DBIx::Class::DeploymentHandler::Dad';
# a single with would be better, but we can't do that
# see: http://rt.cpan.org/Public/Bug/Display.html?id=46347
with 'DBIx::Class::DeploymentHandler::WithApplicatorDumple' => {
    interface_role       => 'DBIx::Class::DeploymentHandler::HandlesDeploy',
    class_name           => 'DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator',
    delegate_name        => 'deploy_method',
    attributes_to_assume => [qw(schema schema_version)],
    attributes_to_copy   => [qw(
      ignore_ddl databases script_directory sql_translator_args force_overwrite
    )],
  },
  'DBIx::Class::DeploymentHandler::WithApplicatorDumple' => {
    interface_role       => 'DBIx::Class::DeploymentHandler::HandlesVersioning',
    class_name           => 'DBIx::Class::DeploymentHandler::VersionHandler::Monotonic',
    delegate_name        => 'version_handler',
    attributes_to_assume => [qw( database_version schema_version to_version )],
  },
  'DBIx::Class::DeploymentHandler::WithApplicatorDumple' => {
    interface_role       => 'DBIx::Class::DeploymentHandler::HandlesVersionStorage',
    class_name           => 'DBIx::Class::DeploymentHandler::VersionStorage::Standard',
    delegate_name        => 'version_storage',
    attributes_to_assume => ['schema'],
  };
with 'DBIx::Class::DeploymentHandler::WithReasonableDefaults';

sub prepare_version_storage_install {
  my $self = shift;

  $self->prepare_resultsource_install({
    result_source => $self->version_storage->version_rs->result_source
  });
}

sub install_version_storage {
  my $self = shift;

  my $version = (shift||{})->{version} || $self->schema_version;

  $self->install_resultsource({
    result_source => $self->version_storage->version_rs->result_source,
    version       => $version,
  });
}

sub prepare_install {
  $_[0]->prepare_deploy;
  $_[0]->prepare_version_storage_install;
}

# the following is just a hack so that ->version_storage
# won't be lazy
sub BUILD { $_[0]->version_storage }
__PACKAGE__->meta->make_immutable;

1;

#vim: ts=2 sw=2 expandtab

__END__

=pod

=head1 NAME

DBIx::Class::DeploymentHandler - Extensible DBIx::Class deployment

=head1 SYNOPSIS

 use aliased 'DBIx::Class::DeploymentHandler' => 'DH';
 my $s = My::Schema->connect(...);

 my $dh = DH->new({
   schema              => $s,
   databases           => 'SQLite',
   sql_translator_args => { add_drop_table => 0 },
 });

 $dh->prepare_install;

 $dh->install;

or for upgrades:

 use aliased 'DBIx::Class::DeploymentHandler' => 'DH';
 my $s = My::Schema->connect(...);

 my $dh = DH->new({
   schema              => $s,
   databases           => 'SQLite',
   sql_translator_args => { add_drop_table => 0 },
 });

 $dh->prepare_deploy;
 $dh->prepare_upgrade({
   from_version => 1,
   to_version   => 2,
 });

 $dh->upgrade;

=head1 DESCRIPTION

C<DBIx::Class::DeploymentHandler> is, as its name suggests, a tool for
deploying and upgrading databases with L<DBIx::Class>.  It is designed to be
much more flexible than L<DBIx::Class::Schema::Versioned>, hence the use of
L<Moose> and lots of roles.

C<DBIx::Class::DeploymentHandler> itself is just a recommended set of roles
that we think will not only work well for everyone, but will also yield the
best overall mileage.  Each role it uses has its own nuances and
documentation, so I won't describe all of them here, but here are a few of the
major benefits over how L<DBIx::Class::Schema::Versioned> worked (and
L<DBIx::Class::DeploymentHandler::Deprecated> tries to maintain compatibility
with):

=over

=item *

Downgrades in addition to upgrades.

=item *

Multiple sql files files per upgrade/downgrade/install.

=item *

Perl scripts allowed for upgrade/downgrade/install.

=item *

Just one set of files needed for upgrade, unlike before where one might need
to generate C<factorial(scalar @versions)>, which is just silly.

=item *

And much, much more!

=back

That's really just a taste of some of the differences.  Check out each role for
all the details.

=head1 WHERE IS ALL THE DOC?!

C<DBIx::Class::DeploymentHandler> extends
L<DBIx::Class::DeploymentHandler::Dad>, so that's probably the first place to
look when you are trying to figure out how everything works.

Next would be to look at all the pieces that fill in the blanks that
L<DBIx::Class::DeploymentHandler::Dad> expects to be filled.  They would be
L<DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator>,
L<DBIx::Class::DeploymentHandler::VersionHandler::Monotonic>,
L<DBIx::Class::DeploymentHandler::VersionStorage::Standard>, and
L<DBIx::Class::DeploymentHandler::WithReasonableDefaults>.

=head1 WHY IS THIS SO WEIRD

C<DBIx::Class::DeploymentHandler> has a strange structure.  The gist is that it
delegates to three small objects that are proxied to via interface roles that
then create the illusion of one large, monolithic object.  Here is a diagram
that might help:

=begin text

Figure 1

                    +------------+
                    |            |
       +------------+ Deployment +-----------+
       |            |  Handler   |           |
       |            |            |           |
       |            +-----+------+           |
       |                  |                  |
       |                  |                  |
       :                  :                  :
       v                  v                  v
  /-=-------\        /-=-------\       /-=----------\
  |         |        |         |       |            |  (interface roles)
  | Handles |        | Handles |       |  Handles   |
  | Version |        | Deploy  |       | Versioning |
  | Storage |        |         |       |            |
  |         |        \-+--+--+-/       \-+---+---+--/
  \-+--+--+-/          |  |  |           |   |   |
    |  |  |            |  |  |           |   |   |
    |  |  |            |  |  |           |   |   |
    v  v  v            v  v  v           v   v   v
 +----------+        +--------+        +-----------+
 |          |        |        |        |           |  (implementations)
 | Version  |        | Deploy |        |  Version  |
 | Storage  |        | Method |        |  Handler  |
 | Standard |        | SQLT   |        | Monotonic |
 |          |        |        |        |           |
 +----------+        +--------+        +-----------+

=end text

=for html <p><i>Figure 1</i><img src="data:image/png;base64,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"></img></p>

The nice thing about this is that we have well defined interfaces for the
objects that comprise the C<DeploymentHandler>, the smaller objects can be
tested in isolation, and the smaller objects can even be swapped in easily.  But
the real win is that you can subclass the C<DeploymentHandler> without knowing
about the underlying delegation; you just treat it like normal Perl and write
methods that do what you want.

=head1 THIS SUCKS

You started your project and weren't using C<DBIx::Class::DeploymentHandler>?
Lucky for you I had you in mind when I wrote this doc.

First,
L<define the version|DBIx::Class::DeploymentHandler::Manual::Intro/Sample_database>
in your main schema file (maybe using C<$VERSION>).

Then you'll want to just install the version_storage:

 my $s = My::Schema->connect(...);
 my $dh = DBIx::Class::DeploymentHandler->new({ schema => $s });

 $dh->prepare_version_storage_install;
 $dh->install_version_storage;

Then set your database version:

 $dh->add_database_version({ version => $s->schema_version });

Now you should be able to use C<DBIx::Class::DeploymentHandler> like normal!

=head1 LOGGING

This is a complex tool, and because of that sometimes you'll want to see
what exactly is happening.  The best way to do that is to use the built in
logging functionality.  It the standard six log levels; C<fatal>, C<error>,
C<warn>, C<info>, C<debug>, and C<trace>.  Most of those are pretty self
explanatory.  Generally a safe level to see what all is going on is debug,
which will give you everything except for the exact SQL being run.

To enable the various logging levels all you need to do is set an environment
variables: C<DBICDH_FATAL>, C<DBICDH_ERROR>, C<DBICDH_WARN>, C<DBICDH_INFO>,
C<DBICDH_DEBUG>, and C<DBICDH_TRACE>.  Each level can be set on its own,
but the default is the first three on and the last three off, and the levels
cascade, so if you turn on trace the rest will turn on automatically.

=head1 DONATIONS

If you'd like to thank me for the work I've done on this module, don't give me
a donation. I spend a lot of free time creating free software, but I do it
because I love it.

Instead, consider donating to someone who might actually need it.  Obviously
you should do research when donating to a charity, so don't just take my word
on this.  I like Matthew 25: Ministries:
L<http://www.m25m.org/>, but there are a host of other
charities that can do much more good than I will with your money.
(Third party charity info here:
L<http://www.charitynavigator.org/index.cfm?bay=search.summary&orgid=6901>

=head1 METHODS

=head2 prepare_version_storage_install

 $dh->prepare_version_storage_install

Creates the needed C<.sql> file to install the version storage and not the rest
of the tables

=head2 prepare_install

 $dh->prepare_install

First prepare all the tables to be installed and the prepare just the version
storage

=head2 install_version_storage

 $dh->install_version_storage

Install the version storage and not the rest of the tables

=head1 AUTHOR

Arthur Axel "fREW" Schmidt <frioux+cpan@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Arthur Axel "fREW" Schmidt.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
