##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim header

##  #pragma c2nim importc

##  #pragma c2nim render nobody

##  Copyright 2023 Open Source Robotics Foundation, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##  \file Provides a simple SHA256 algorithm for hashing.
##  This implementation makes no security guarantees, its use case
##  is for non-sensitive comparison of message digests
##  Implementation originally copied from Brad Conte
##  https://github.com/B-Con/crypto-algorithms/blob/master/sha256.c
##  \file sha256.h
##   \brief SHA256 implementation
##
##   This contains an implementation of the SHA256 algorithm
##   It was originally copied from Brad Conte
##   https://github.com/B-Con/crypto-algorithms/blob/master/sha256.c
##   and modified to meet ros2 code formatting and compiler warning requirements.
##   Algorithm specification can be found here:
##   http://csrc.nist.gov/publications/fips/fips180-2/fips180-2withchangenotice.pdf
##   This implementation uses little endian byte order.
##

import
  ./visibility_control, ./visibility_control_macros, ./visibility_control_macros,
  ./visibility_control

const
  RCUTILS_SHA256_BLOCK_SIZE* = 32

type

  rcutils_sha256_ctx_t* {.importc: "rcutils_sha256_ctx_t", header: "sha256.h", bycopy.} = object
    data* {.importc: "data".}: array[64, uint8]
    datalen* {.importc: "datalen".}: csize_t
    bitlen* {.importc: "bitlen".}: uint64
    state* {.importc: "state".}: array[8, uint32]



proc rcutils_sha256_init*(ctx: ptr rcutils_sha256_ctx_t) {.
    importc: "rcutils_sha256_init", header: "sha256.h".}
  ##  Initialize the sha256 algorithm context with starting state.
  ##
  ##  Call this on any new context before starting to input data.
  ##
  ##  \param[inout] ctx
  ##  \return void
  ##

proc rcutils_sha256_update*(ctx: ptr rcutils_sha256_ctx_t; data: ptr uint8;
                           data_len: csize_t) {.importc: "rcutils_sha256_update",
    header: "sha256.h".}
  ##  Add data to the sha256 algorithm
  ##
  ##  This may be called repeatedly on an initialized context.
  ##
  ##  \param[inout] ctx Initialized sha256 context struct
  ##  \param[in] data Data to add to the total message being hashed
  ##  \param[in] data_len Size of the input data.
  ##  \return void
  ##

proc rcutils_sha256_final*(ctx: ptr rcutils_sha256_ctx_t;
                          output_hash: array[32, uint8]) {.
    importc: "rcutils_sha256_final", header: "sha256.h".}
  ##  Finalize and output sha256 hash for all data added.
  ##
  ##  Call only once on a context that has been initialized, and optionally updated with data.
  ##
  ##  \param[inout] ctx Initialized sha256 context struct
  ##  \param[out] output_hash Calculated sha256 message digest to be filled
  ##  \return void
  ## 