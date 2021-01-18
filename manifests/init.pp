# Class: mailhog
# ===========================
#
#
# Ian Kent did a wonderful job on developing MailHog
# (https://github.com/mailhog/).
#
# A nice little tool you could use to receive mail and show them in a smart
#  WebUI.
# The advantage is MailHog doesn't care about domains and users. It just lists
# all received mails (no matter what source or destination) in its WebUI.
# So it's perfectly easy to check what mails are processed on the local system.
#
# Mailhog sets up a small MTA like daemon to receive incoming mail. It defaults
# to port 1025 for incoming smtp traffic as the service is running as
# non-root user.
# So make sure to send all mail to this port. To do this one could use a tool
# like nullmailer. If required one could release individual mails to a real
# world SMTP server for convenience.
#
#
# This puppet module installs and configures MailHog on a linux system.
# It provides a init.d script along with a configuration.
#
class mailhog (
  String           $api_bind_ip          = $mailhog::params::api_bind_ip,
  String           $api_bind_port        = $mailhog::params::api_bind_port,
  Optional[String] $api_bind_host        = $mailhog::params::api_bind_host,
  Optional[String] $cors_origin          = $mailhog::params::cors_origin,
  String           $hostname             = $mailhog::params::hostname,
  Boolean          $invite_jim           = $mailhog::params::invite_jim,
  String           $jim_accept           = $mailhog::params::jim_accept,
  String           $jim_disconnect       = $mailhog::params::jim_disconnect,
  String           $jim_linkspeed_affect = $mailhog::params::jim_linkspeed_affect,
  String           $jim_linkspeed_max    = $mailhog::params::jim_linkspeed_max,
  String           $jim_linkspeed_min    = $mailhog::params::jim_linkspeed_min,
  String           $jim_reject_auth      = $mailhog::params::jim_reject_auth,
  String           $jim_reject_recipient = $mailhog::params::jim_reject_recipient,
  String           $jim_reject_sender    = $mailhog::params::jim_reject_sender,
  String           $mongo_coll           = $mailhog::params::mongo_coll,
  String           $mongo_db             = $mailhog::params::mongo_db,
  String           $mongo_uri_ip         = $mailhog::params::mongo_uri_ip,
  String           $mongo_uri_port       = $mailhog::params::mongo_uri_port,
  Optional[String] $outgoing_smtp        = $mailhog::params::outgoing_smtp,
  String           $smtp_bind_addr_ip    = $mailhog::params::smtp_bind_addr_ip,
  String           $smtp_bind_addr_port  = $mailhog::params::smtp_bind_addr_port,
  String           $storage              = $mailhog::params::storage,
  String           $ui_bind_addr_ip      = $mailhog::params::ui_bind_addr_ip,
  String           $ui_bind_addr_port    = $mailhog::params::ui_bind_addr_port,
  String           $ui_web_path          = $mailhog::params::ui_web_path,
  String           $config_template      = $mailhog::params::config_template,
  String           $init_template        = $mailhog::params::init_template,
  String           $config               = $mailhog::params::config,
  String           $init                 = $mailhog::params::init,
  Boolean          $service_manage       = $mailhog::params::service_manage,
  Boolean          $service_enable       = $mailhog::params::service_enable,
  String           $service_ensure       = $mailhog::params::service_ensure,
  String           $service_name         = $mailhog::params::service_name,
  String           $binary_path          = $mailhog::params::binary_path,
  String           $binary_file          = $mailhog::params::binary_file,
  String           $source_file          = $mailhog::params::source_file,
  String           $download_url         = $mailhog::params::download_url,
  String           $user                 = $mailhog::params::user,
  String           $homedir              = $mailhog::params::homedir,
  String           $mailhog_version      = $mailhog::params::mailhog_version,
  Boolean          $download_mailhog     = $mailhog::params::download_mailhog,
) inherits mailhog::params {
    class { '::mailhog::install': }
    class { '::mailhog::config': }
    class { '::mailhog::service': }
}
