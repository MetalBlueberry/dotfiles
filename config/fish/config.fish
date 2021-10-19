set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_COMPLETE 0
set -x EDITOR nvim
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
set -q PATH; or set PATH ''; set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH

set -gx REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
set -gx AWS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
set -gx SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
set -gx NODE_EXTRA_CA_CERTS /etc/ssl/certs/ca-certificates.crt
