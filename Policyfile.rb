name "fc-freeipa"
default_source :supermarket
cookbook "fc-freeipa", path: "./"

run_list "fc-freeipa::default"

named_run_list "fc-freeipa-server", "fc-freeipa::server"
named_run_list "fc-freeipa-client", "fc-freeipa::client"
