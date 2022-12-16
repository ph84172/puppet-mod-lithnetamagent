# lithnetamagent
#
# Main class
#
# @summary This module manages the Lithnet Access Manager agent package.
#
# @example Declaring the class
#   include lithnetamagent
#
# @param register_agent
#   Register the agent with an AMS server
#
# @param ams_server
#   Specify hostname of AMS server
#
# @param reg_key
#   Agent registration key
class lithnetamagent (
  Boolean          $register_agent = false,
  Optional[String] $ams_server     = undef,
  Optional[String] $reg_key        = undef,
) {
  # Check that we're running on a supported platform
  if $facts['os']['family'] == 'RedHat' and !($facts['os']['release']['major'] in ['7','8','9']) {
    fail("Current os.release.major is ${::facts['os']['release']['major']} and must be 7, 8 or 9")
  }
  case $facts['os']['family'] {
    'RedHat' : {
      # Install the Lithnet RPM repo
      # Note: Lithnet don't GPG sign their packages so gpgcheck is disabled
      Yumrepo { 'lithnet-am-repo':
        baseurl  => "https://packages.lithnet.io/linux/rpm/prod/repos/rhel/${facts['os']['release']['major']}",
        descr    => 'Lithnet Access Manager agent',
        enabled  => 1,
        gpgcheck => 0,
      }

      # Install the Lithnet Access Manager agent package
      Package { 'LithnetAccessManagerAgent':
        ensure  => 'installed',
        require => Yumrepo['lithnet-am-repo'],
      }

      # If "register_agent" is true, try to register the agent
      if($register_agent and $ams_server and $reg_key) {
        exec { 'agent-register':
          command => "/opt/LithnetAccessManagerAgent/Lithnet.AccessManager.Agent --server ${ams_server} --registration-key ${reg_key}",
          unless  => "/usr/bin/grep -iq ${ams_server} /etc/LithnetAccessManagerAgent.conf",
          user    => 'root',
          require => Package['LithnetAccessManagerAgent'],
        }
      }
    }
    # If we've ended up here, then this module doesn't currently support the OS
    default : { fail("Unsupported OS ${facts['os']['family']}.") }
  }
}
