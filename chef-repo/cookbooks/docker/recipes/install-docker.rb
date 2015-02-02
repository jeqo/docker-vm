package "git" do
  action :install
end

apt_package "docker.io" do
  action :install
end
