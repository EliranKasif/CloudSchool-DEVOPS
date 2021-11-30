 consul {
 address = "main.services:8500"
  auth {
   enabled = true
   username = "test"
   password = "test"
 }
}
 
log_level = "warn"

# render the role with the new value and re run python application 
template {
 source = "consul-config-app.tpl"
 destination = "./CloudSchool-DEVOPS/PythonRestApi/code/config/app.conf"
  exec {
    command = "python3 ./CloudSchool-DEVOPS/PythonRestApi/code/app.py> ./consul-template.log"
  }
}
