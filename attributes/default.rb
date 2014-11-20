default[:pureftpd][:user] = 'ftpusers'
default[:pureftpd][:group] = 'ftpusers'

default[:pureftpd][:config][:ChrootEveryone] = 'yes'
default[:pureftpd][:config][:PAMAuthentication] = 'no'
default[:pureftpd][:config][:PureDB] = '/etc/pure-ftpd/pureftpd.pdb'
default[:pureftpd][:config][:SyslogFacility] = 'none'

default[:pureftpd][:accounts] = [] # login password path
