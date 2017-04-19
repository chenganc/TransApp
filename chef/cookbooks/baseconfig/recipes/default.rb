# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'sudo apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end


# Config for exercise 7
package "ruby-dev"
package "ruby-railties"
package "sqlite3"
package "libsqlite3-dev"
package "libpq-dev"
package "build-essential"

execute "install pg" do
  command 'apt-get install libpq-dev'
end


package "postgresql"
execute 'postgresql_init' do
  command 'echo "CREATE DATABASE myapp_production; CREATE USER ubuntu; GRANT ALL PRIVILEGES ON DATABASE myapp_production TO ubuntu;" | sudo -u postgres psql'
end

execute 'postgresql_db' do
  command 'echo "psql myapp_production;"'
end

package "zlib1g-dev"
package "nodejs"

execute "apt-get dist-upgrade" do
  command 'sudo apt-get -y dist-upgrade'
end

execute 'bundler install' do
  command 'gem install bundler --conservative'
end

execute 'rails install' do
  command 'gem install rails'
end

execute 'pkg-config install' do
  command 'gem install pkg-config'
end



execute 'nokogiri install' do
  command 'gem install nokogiri -- --use-system-libraries'
end


execute 'bundle' do
  cwd '/home/ubuntu/project/'
  command 'bundle install'
  user 'ubuntu'
end


cookbook_file "unicorn_rails" do
  path "/etc/init.d/unicorn_project"
end

execute 'unicorn_config_1' do
  command 'sudo chmod 755 /etc/init.d/unicorn_project'
end

execute 'unicorn_config_2' do
	command 'sudo update-rc.d unicorn_project defaults'
end

# Config for exercise 4
package "nginx"
  cookbook_file "nginx-default" do
    path "/etc/nginx/sites-available/default"
end

execute 'nginx_restart' do
  command 'service nginx restart'
end

execute 'nginx_read_styling' do
  cwd '/home/ubuntu/project/'
  command 'sudo RAILS_ENV=production rake assets:precompile'
  user 'ubuntu'
end

execute 'migrate' do
  cwd '/home/ubuntu/project/'
  command 'rake db:migrate RAILS_ENV=production'
  user 'ubuntu'
end

execute 'seed' do
  cwd '/home/ubuntu/project/'
  command 'rake db:seed RAILS_ENV=production'
  user 'ubuntu'
end

execute 'mkdir' do
  cwd '/home/ubuntu/project/tmp'
  command 'sudo mkdir pids'
  user 'ubuntu'
end

execute 'unicorn server start' do
  cwd '/home/ubuntu/project'
  command 'bundle exec unicorn -E production -c config/unicorn.rb'
  user 'ubuntu'
end
