 
consul {
 address = "$MAIN_INSTANCE_IP"
}
 
log_level = "warn"

# render the role with the new value and re run python application 
template {
 source = "consul-config-app.tpl"
 destination = "$HOME/CloudSchool-DEVOPS/PythonRestApi/code/config/app.conf"
  exec {
    command = "python3 $HOME/CloudSchool-DEVOPS/PythonRestApi/code/app.py> $HOME/consul-template.log"
  }
}