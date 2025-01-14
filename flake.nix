{
  description = "Hackpkg flake";

  inputs.nixpkgs.url = github:NixOS/nixpkgs;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
      in rec {
        packages = flake-utils.lib.flattenTree {
          dirbuster = pkgs.callPackage ./pkgs/tools/security/dirbuster { };

          # exploitdb = pkgs.callPackage ./pkgs/tools/security/exploitdb { };

          GTFOBLookup = pkgs.callPackage ./pkgs/tools/security/GTFOBLookup { };

          # logic = pkgs.callPackage ./pkgs/tools/misc/logic { };

          # msodbcsql = pkgs.callPackage ./pkgs/development/libraries/msodbcsql { };
          # download.microsoft.com is down lmao

          # mssql-tools = pkgs.callPackage ./pkgs/applications/misc/mssql-tools { };
          # download.microsoft.com is down lmao

          netdiscover = pkgs.callPackage ./pkgs/tools/security/netdiscover { };

          nikto = pkgs.callPackage ./pkgs/tools/security/nikto { };

          # pwncat = pkgs.pythonPackages.callPackage ./pkgs/tools/security/pwncat {} ;

          stegsolve = pkgs.callPackage ./pkgs/tools/security/stegsolve { };

          superenum = pkgs.callPackage ./pkgs/tools/security/superenum { };

          sherlock = pkgs.callPackage ./pkgs/tools/security/sherlock {
            requests-futures = python3Packages.requests-futures;
            torrequest = python3Packages.torrequest;
          };

        };
        python3Packages = pkgs.python3.pkgs // (with pkgs.python3.pkgs; rec {
          altgraph = callPackage ./pkgs/development/python-modules/altgraph { };
          argparse = callPackage ./pkgs/development/python-modules/argparse { };
          base64io = callPackage ./pkgs/development/python-modules/base64io { };
          clipboard = callPackage ./pkgs/development/python-modules/clipboard { };
          Flask = callPackage ./pkgs/development/python-modules/Flask { };
          flasgger = callPackage ./pkgs/development/python-modules/flasgger { };
          katana = callPackage ./pkgs/tools/misc/katana {
            argparse = argparse;
            clipboard = clipboard;
            python-magic = python-magic;
            pyzbar = pyzbar;
          };
          macholib = callPackage ./pkgs/development/python-modules/macholib { };
          mbstrdecoder = callPackage ./pkgs/development/python-modules/mbstrdecoder { };
          paramiko = callPackage ./pkgs/development/python-modules/paramiko { };
          python-magic = callPackage ./pkgs/development/python-modules/python-magic { };
          pyinstaller = callPackage ./pkgs/development/python-modules/pyinstaller { };
          pyminifier = callPackage ./pkgs/development/python-modules/pyminifier { };
          pyinstaller-hooks-contrib = callPackage ./pkgs/development/python-modules/pyinstaller-hooks-contrib { };
          PyYAML = callPackage ./pkgs/development/python-modules/PyYAML { };
          pyzbar = callPackage ./pkgs/development/python-modules/pyzbar { };
          requests-futures = python.pkgs.callPackage ./pkgs/development/python-modules/requests-futures { };
          # sherlock = callPackage ./pkgs/tools/security/sherlock {
          #   requests-futures = requests-futures;
          #   torrequest = torrequest;
          # };
          sphinx-rtd-theme = callPackage ./pkgs/development/python-modules/sphinx-rtd-theme { };
          sublist3r = callPackage ./pkgs/tools/security/sublist3r { argparse = argparse; };
          torrequest = callPackage ./pkgs/development/python-modules/torrequest { };
          typepy = callPackage ./pkgs/development/python-modules/typepy { mbstrdecoder = mbstrdecoder; };
          xlutils = callPackage ./pkgs/development/python-modules/xlutils { };
          zlib_wrapper = callPackage ./pkgs/development/python-modules/zlib_wrapper { };

          # # empire = python.pkgs.callPackage ./pkgs/tools/security { };
          httpbin = callPackage ./pkgs/servers/httpbin { };

          # metagoofil = callPackage ./pkgs/tools/security/metagoofil { pdfminer = pdfminer; };
        });
      }
    );
}
