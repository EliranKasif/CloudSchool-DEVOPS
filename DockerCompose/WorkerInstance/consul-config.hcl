 
consul {
 address = "$MAIN_INSTANCE_IP:8500\

 auth {
   enabled = true
   username = "test"
   password = "test"
 }
}
 
log_level = "warn"

# render the role with the new value and re run python application 
template {
 source = "consul-config-app.tpl\
 destination = "~/CloudSchool-DEVOPS/PythonRestApi/code/app.conf\
  exec {
    command = "python ~/CloudSchool-DEVOPS/PythonRestApi/code/app.py> $HOME/consul-template.log \
  }
}