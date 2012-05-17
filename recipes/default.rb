
execute "locale-gen" do
  action :nothing
  command "locale-gen #{node.locale}"
end

execute "update-locale" do
  action :nothing
  command "update-locale #{node.locale}"
end

template '/etc/default/locale' do
  only_if { node.current_user == 'root' }
  mode 0644
  source "locale.erb"
  notifies :run, "execute[locale-gen]", :immediately
  notifies :run, "execute[update-locale]", :immediately
end

