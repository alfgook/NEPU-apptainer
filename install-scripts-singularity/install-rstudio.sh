
# Install RStudio Server
apt-get update
apt-get install -y --no-install-recommends \
	ca-certificates \
	wget \
	gdebi-core
wget \
	--no-verbose \
	-O rstudio-server.deb \
	"https://download2.rstudio.org/server/focal/amd64/rstudio-server-2023.12.1-402-amd64.deb"
	gdebi -n rstudio-server.deb
	rm -f rstudio-server.deb

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /var/lib/rstudio-server/secure-cookie-key