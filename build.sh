#!/usr/bin/env bash

# Debug
#set -x

VERSION="$1"

matchesRegex() {
    local regex="$1"
    local value="$2"

    echo $value | grep -E "$regex" > /dev/null
}

if [ -z "$VERSION" ] || ! matchesRegex '^[0-9]+\.[0-9]+\.[0-9]+$' "$VERSION"; then
    echo "A version number is required and should follow semantic versioning" >&2
    exit 1
fi

for filePath in $(find . -name Dockerfile)
do
    imagePath="$(dirname $filePath)"
    tag="$(echo "v${VERSION}-$(echo $imagePath | sed -e 's#/#-#g')" | sed -e 's#-.-#-#g')"

    echo "Building ${tag} from ${filePath}"
    docker build -t "ribeirobreno/php:${tag}" "$imagePath" || exit $?
    #docker push "ribeirobreno/php:${tag}"
done