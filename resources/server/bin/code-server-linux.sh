#!/usr/bin/env sh
#
# Copyright (c) Microsoft Corporation. All rights reserved.
#

case "$1" in
	--inspect*) INSPECT="$1"; shift;;
esac

ROOT="$(dirname "$(dirname "$(readlink -f "$0")")")"

if [ -n "$VSCODE_SERVER_CUSTOM_GLIBC_LINKER" ] && [ -n "$VSCODE_SERVER_CUSTOM_GLIBC_PATH" ] && [ -n "$VSCODE_SERVER_PATCHELF_PATH" ]; then
	"$VSCODE_SERVER_PATCHELF_PATH" --set-rpath "$VSCODE_SERVER_CUSTOM_GLIBC_PATH" "$ROOT/node"
	"$VSCODE_SERVER_PATCHELF_PATH" --set-interpreter "$VSCODE_SERVER_CUSTOM_GLIBC_LINKER" "$ROOT/node"
fi

"$ROOT/node" ${INSPECT:-} "$ROOT/out/server-main.js" "$@"
