manifest := "com.fflogs.FFLogs.yaml"

default:
  @just --list

install deps-repo="flathub-user":
  flatpak run org.flatpak.Builder --force-clean --sandbox --user --install --install-deps-from={{deps-repo}} --ccache --mirror-screenshots-url=https://dl.flathub.org/media/ --repo=repo builddir {{manifest}}

lint:
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest {{manifest}}
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder repo repo
