#!/bin/bash
#
# Copyright (c) 2019 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

set -o errexit
set -o nounset
set -o pipefail

script_dir=$(dirname $(readlink -f "$0"))
docker_image="cloud-hypervisor-builder"

docker build -t "${docker_image}" "${script_dir}"
docker run \
	--rm \
	-v "$(pwd):/$(pwd)" \
	-w "$(pwd)" \
	--env "CARGO_HOME=$(pwd)" \
	-ti \
	"${docker_image}" \
	cargo build --release
