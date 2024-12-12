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

FROM gcr.io/oss-fuzz-base/base-builder
RUN apt-get update && apt-get install -y lsb-release

# Install and clone IRODS
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -
RUN echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list
RUN apt-get update && apt-get install -y make libtool curl libcurl4-openssl-dev libssl-dev cmake libboost-all-dev libc++-dev libc++abi-dev
RUN apt-get update && apt-get install -y irods-externals-cmake3.21.4-0 irods-externals-cmake3.21.4-0 irods-dev irods-runtime irods-externals-jwt-cpp0.6.99.0-0 irods-externals-boost1.81.0-1 irods-externals-spdlog1.9.2-2 
RUN git clone --depth 1 https://github.com/andrewcsu/irods_client_http_api.git irods_client_http_api

# Install and clone AFLPlusPlus
RUN sudo apt-get install -y build-essential python3-dev automake cmake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev
RUN sudo apt-get install -y lld-14 llvm-14 llvm-14-dev clang-14 || sudo apt-get install -y lld llvm llvm-dev clang
RUN sudo apt-get install -y gcc-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-plugin-dev libstdc++-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-dev
RUN sudo apt-get install -y ninja-build cpio libcapstone-dev wget curl python3-pip
RUN git clone https://github.com/AFLplusplus/AFLplusplus

WORKDIR AFLplusplus
WORKDIR irods_client_http_api
COPY build.sh $SRC/
