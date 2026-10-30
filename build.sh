#!/usr/bin/env bash
set -euo pipefail

JAVA27_HOME=""
for candidate in \
    /opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home \
    /opt/homebrew/opt/openjdk@27/libexec/openjdk.jdk/Contents/Home \
    /usr/lib/jvm/java-27-openjdk \
    /usr/lib/jvm/java-27-openjdk-amd64; do
    if [[ -x "$candidate/bin/java" ]] && "$candidate/bin/java" -version 2>&1 | grep -q '^openjdk version "27'; then
        JAVA27_HOME="$candidate"
        break
    fi
done

if [[ -z "$JAVA27_HOME" ]]; then
    if [[ -n "${JAVA_HOME:-}" && -x "${JAVA_HOME}/bin/java" ]] && "$JAVA_HOME/bin/java" -version 2>&1 | grep -q '^openjdk version "27'; then
        JAVA27_HOME="$JAVA_HOME"
    fi
fi

if [[ -z "$JAVA27_HOME" ]]; then
    echo "Java 27 not found. Set JAVA_HOME to a JDK 27 installation." >&2
    exit 1
fi

export JAVA_HOME="$JAVA27_HOME"
export PATH="$JAVA_HOME/bin:$PATH"

echo "Using JAVA_HOME=$JAVA_HOME"
java -version

mvn -B clean package "$@"
