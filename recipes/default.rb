package 'pure-ftpd'

service 'pure-ftpd'

group node[:pureftpd][:group]

user node[:pureftpd][:user] do
  gid node[:pureftpd][:group]
  home '/dev/null'
  shell '/bin/false'
end

node[:pureftpd][:config].each do |key, value|
  file "/etc/pure-ftpd/conf/#{key}" do
    content value
    notifies :restart, 'service[pure-ftpd]'
  end
end

link '/etc/pure-ftpd/auth/PureDB' do
  to '/etc/pure-ftpd/conf/PureDB'
  notifies :restart, 'service[pure-ftpd]'
end

template '/etc/pure-ftpd/pureftpd.passwd' do
  source 'pureftpd.passwd.erb'
  variables(
    accounts: node[:pureftpd][:accounts],
    uid: `id -u #{node[:pureftpd][:user]}`.strip,
    gid: `id -g #{node[:pureftpd][:group]}`.strip
  )
  mode 0600
  notifies :run, 'execute[Update pureftpd database]', :immediately
end

execute 'Update pureftpd database' do
  command 'pure-pw mkdb'
  action :nothing
end
