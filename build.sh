#!/usr/bin/env bash

set -xeuo pipefail

if [[ ! -d "$PWD/build" ]]; then
  mkdir build
fi

rm -rf build/*

pushd charts/codimd
  helm dependency update
popd

pushd build
  helm package ../charts/codimd
  git checkout gh-pages
  helm repo index --merge ../index.yaml .
  mv codimd*.tgz ../
  mv index.yaml ../
popd
