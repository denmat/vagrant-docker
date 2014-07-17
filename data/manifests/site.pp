hiera_include('classes')

#resources { "firewall":
#  purge => true
#}

# all nodes are declared the same way and use hiera data to configure.
node default {
}