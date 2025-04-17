{ inputs, ... }:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    hosts = {

      # personal machine
      duncan = { };
    };
  };

}
