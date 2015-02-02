apt_package "python-pip" do
  action :install
end

pip_install = "sudo pip install -U fig"

execute pip_install do
  action :run
end
