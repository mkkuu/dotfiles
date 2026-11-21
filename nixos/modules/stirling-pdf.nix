{ config, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
  };

  virtualisation.oci-containers = {
    backend = "podman";

    containers.stirling-pdf = {
      image = "docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest";

      autoStart = true;

      ports = [
        "127.0.0.1:8080:8080"
      ];

      volumes = [
        "/var/lib/stirling-pdf/configs:/configs"
        "/var/lib/stirling-pdf/logs:/logs"
        "/var/lib/stirling-pdf/tessdata:/usr/share/tessdata"
        "/var/lib/stirling-pdf/customFiles:/customFiles"
        "/var/lib/stirling-pdf/pipeline:/pipeline"
      ];

      environment = {
        SECURITY_ENABLELOGIN = "true";
        SYSTEM_DEFAULTLOCALE = "fr-FR";
        SYSTEM_GOOGLEVISIBILITY = "false";
      };

      extraOptions = [
        "--cap-drop=ALL"
        "--security-opt=no-new-privileges:true"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/stirling-pdf 0750 root root -"
    "d /var/lib/stirling-pdf/configs 0750 root root -"
    "d /var/lib/stirling-pdf/logs 0750 root root -"
    "d /var/lib/stirling-pdf/tessdata 0750 root root -"
    "d /var/lib/stirling-pdf/customFiles 0750 root root -"
    "d /var/lib/stirling-pdf/pipeline 0750 root root -"
  ];
}
