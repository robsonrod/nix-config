{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    neofetch
    git
    curl
    wget
    nixfmt-rfc-style
    bc

    autoconf
    automake
    autoconf-archive
    bash-completion
    binutils
    bison
    ccache
    clang-tools
    cmake
    cppcheck
    dialog
    flex
    gcc
    gawk
    gdb
    gnupg
    keyutils
    kmod
    libtool
    m4
    nasm
    ninja
    pkg-config
    sqlite
    valgrind
    wget
    bear
    gnumake
    conan
    cgdb

    # Libraries
    bzip2
    zlib
    xz
    libffi
    gmp
    mpfr
    ncurses
    readline
    openssl
    libuuid

    # Python
    python3
    python3Packages.pip
    pipx

    # Networking & SSH
    inetutils  # includes ping, etc.
    openssh

    # Archiving
    zip
    unzip
    p7zip
    upx

    # Misc
    time
    lsb-release
    tzdata
    #locales

    bat
    jq
    ccls
    eza
    fd
    fzf
    vivid
    grc
    direnv
    hexyl
    hstr
    iproute2
    procps
    ripgrep
    scons
    strace
    tmux
    tmuxinator
    zoxide
    bottom
    starship

  ];

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    emacs = {
      enable = true;
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };

  };

  services = {
    ssh-agent.enable = true;
  };

}
