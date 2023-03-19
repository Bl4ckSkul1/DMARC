#!/bin/sh
echo " ██▒   █▓ ▄▄▄       ███▄ ▄███▓ ██▓███    ▄████  ██▓ ██▀███   ██▓    "
echo "▓██░   █▒▒████▄    ▓██▒▀█▀ ██▒▓██░  ██▒ ██▒ ▀█▒▓██▒▓██ ▒ ██▒▓██▒    "
echo " ▓██  █▒░▒██  ▀█▄  ▓██    ▓██░▓██░ ██▓▒▒██░▄▄▄░▒██▒▓██ ░▄█ ▒▒██░    "
echo "  ▒██ █░░░██▄▄▄▄██ ▒██    ▒██ ▒██▄█▓▒ ▒░▓█  ██▓░██░▒██▀▀█▄  ▒██░    "
echo "   ▒▀█░   ▓█   ▓██▒▒██▒   ░██▒▒██▒ ░  ░░▒▓███▀▒░██░░██▓ ▒██▒░██████▒"
echo "   ░ ▐░   ▒▒   ▒█░░ ▒░   ░  ░▒▓▒░ ░  ░ ░▒   ▒ ░▓  ░ ▒▓ ░▒▓░░ ▒░▓  ░"
echo "   ░ ░░    ▒   ▒▒ ░░  ░      ░░▒ ░       ░   ░  ▒ ░  ░▒ ░ ▒░░ ░ ▒  ░"
echo "     ░░    ░   ▒   ░      ░   ░░       ░ ░   ░  ▒ ░  ░░   ░   ░ ░   "
echo "      ░        ░  ░       ░                  ░  ░     ░         ░  ░"
echo "     ░                                                              "

# Pedimos al usuario que ingrese el dominio que desea verificar
echo "Ingrese el dominio que desea verificar:"
read domain

# Verificar SPF
echo "Verificando SPF..."
spf_result=$(dig +short TXT $domain | grep "v=spf1")
if [[ ! -z $spf_result ]]; then
  echo "La configuración SPF está activa en el dominio $domain"
  echo "Configuración SPF:"
  dig +short TXT $domain | grep "v=spf1"
else
  echo "La configuración SPF no está activa en el dominio $domain"
fi

# Verificar DKIM
echo "Verificando DKIM..."
dkim_result=$(dig +short TXT dkim._domainkey.$domain | grep "v=DKIM1")
if [[ ! -z $dkim_result ]]; then
  echo "La configuración DKIM está activa en el dominio $domain"
  echo "Configuración DKIM:"
  dig +short TXT dkim._domainkey.$domain | grep "v=DKIM1"
else
  echo "La configuración DKIM no está activa en el dominio $domain"
fi

# Verificar DMARC
echo "Verificando DMARC..."
dmarc_result=$(dig +short TXT _dmarc.$domain | grep "v=DMARC1")
if [[ ! -z $dmarc_result ]]; then
  echo "La configuración DMARC está activa en el dominio $domain"
  echo "Configuración DMARC:"
  dig +short TXT _dmarc.$domain | grep "v=DMARC1"
else
  echo "La configuración DMARC no está activa en el dominio $domain"
fi
