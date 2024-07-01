echo "Installing go"

if ! command -v go &> /dev/null; then
    profile=$(eval echo "~$USER")/.profile

    curl "https://go.dev/dl/$(curl https://go.dev/VERSION?m=text | head -n 1).linux-amd64.tar.gz" -o ./go.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf ./go.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $profile
    # @TODO verify installation
    echo "go has been installed"
else
    echo "go was already installed"
fi
