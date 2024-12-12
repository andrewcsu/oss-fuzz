#!/bin/bash -eu
# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

#Build AFLPlusPlus
cd $SRC/AFLplusplus
make distrib

# Set working directory
cd $SRC/irods_client_http_api
git pull
mkdir build && cd build

# Build the project
cmake -DCMAKE_C_COMPILER=$SRC/AFLplusplus/afl-cc -DCMAKE_CXX_COMPILER=$SRC/AFLplusplus/afl-c++ -DCMAKE_EXE_LINKER_FLAGS="-L/usr/lib/llvm-14/lib -lc++ -lc++abi" -DIRODS_HTTP_BUILD_FUZZERS=ON ../ || exit 1

make fuzzer_fuzz_harness -j || exit 1

afl-fuzz -i ../irods_client_http_api/test/fuzz/seeds/http_request/ -o afl_outputs ./test/fuzz/fuzzer_fuzz_harness
