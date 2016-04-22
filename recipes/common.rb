script "enable mkhomedir" do
  interpreter "bash"
  cwd "/tmp"
  code "authconfig --enablemkhomedir --update"
end

service "sssd" do
  action [:enable, :start]
end

service "oddjobd" do
  action [:enable, :start]
end
