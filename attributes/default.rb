default[:monit][:notify_email]          = "notify@example.com"

default[:monit][:logfile]               = 'syslog facility log_daemon'

default[:monit][:poll_period]           = 60
default[:monit][:poll_start_delay]      = 120

default[:monit][:mail_format][:subject] = "$SERVICE $EVENT"
default[:monit][:mail_format][:from]    = "monit@#{node['fqdn']}"
default[:monit][:mail_format][:message]    = <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS

default[:monit][:mailserver][:host] = "localhost"
default[:monit][:mailserver][:port] = nil
default[:monit][:mailserver][:username] = nil
default[:monit][:mailserver][:password] = nil
default[:monit][:mailserver][:password_suffix] = nil

default[:monit][:port] = 3737
default[:monit][:address] = "localhost"
default[:monit][:ssl] = false
default[:monit][:allow] = ["localhost"]

case node['platform_family']
when 'rhel', 'fedora'
default[:monit][:monitrc] = "/etc/monit.conf"
default[:monit][:conf_dir] = "/etc/monit.d"
default[:monit][:eventqueue_basedir] = "/var/monit/events"
default[:monit][:cert] = "/var/cert/monit.pem"
default[:monit][:statefile] = "/var/monit/state"
default[:monit][:idfile] = "/var/monit/id"
else
default[:monit][:monitrc] = "/etc/monit/monitrc"
default[:monit][:conf_dir] = "/etc/monit/conf.d"
default[:monit][:eventqueue_basedir] = "/var/monit"
default[:monit][:cert] = "/etc/monit/monit.pem"
end
