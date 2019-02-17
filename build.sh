#!/usr/bin/env bash
zola_version="0.5.1"

# download repo recursively 
git clone --recurse-submodules -j8 https://github.com/U9H/U9H deploy

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    zola_os="unknown-linux-gnu"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    zola_os="apple-darwin"
else
    echo "Not supported"
    exit 1
fi

# download and unpack Zola if we don't already have it
if [ ! -f zola ]; then
   zola_download="https://github.com/getzola/zola/releases/download/v${zola_version}/zola-v${zola_version}-x86_64-${zola_os}.tar.gz"
    echo "Downloading: ${zola_download}"
    curl -sL $zola_download | tar zxv 
fi

cd deploy

# Build `front` into `/public/`
cd sites/front
../../../zola build -o "../../../public/"

# Build `blog` into `/public/blog/`
cd ../blog
../../../zola build -o "../../../public/blog/"

# clean up
rm -rf deploy