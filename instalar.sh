#!/bin/sh
# Mandarin OS · activa las actualizaciones en un equipo instalado con un ISO de antes de que existieran:
#   wget -qO- https://dacotin2.github.io/mandarin-os/instalar.sh | sudo sh
set -e
URL=https://dacotin2.github.io/mandarin-os
if [ "$(id -u)" != 0 ]; then
	echo "Hace falta sudo:  wget -qO- $URL/instalar.sh | sudo sh" >&2
	exit 1
fi
if command -v wget >/dev/null; then
	wget -qO /usr/share/keyrings/mandarin-os.asc "$URL/mandarin-os.asc"
else
	curl -fsSLo /usr/share/keyrings/mandarin-os.asc "$URL/mandarin-os.asc"
fi
cat > /etc/apt/sources.list.d/mandarin.sources <<FIN
Types: deb
URIs: $URL
Suites: estable
Components: main
Signed-By: /usr/share/keyrings/mandarin-os.asc
FIN
apt-get update
apt-get install -y mandarin-escritorio
echo
echo "Listo. Mandarin OS se actualizará junto con el resto del sistema:"
echo "  Tienda › Actualizaciones, Panel de control › Buscar actualizaciones o «sudo apt update && sudo apt upgrade»."
