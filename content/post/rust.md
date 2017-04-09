---
title: "Rust"
date: "2016-06-01"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips", "rust"]
---

## openssl

I couldn't get any cargo projects that depend on open ssl to build. I just did:

```
brew install openssl
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export DEP_OPENSSL_INCLUDE=/usr/local/opt/openssl/include
```

Answer came from [here](https://github.com/sfackler/rust-openssl/issues/255#issuecomment-163501227)

## openblas

I also had a hard time getting open-blas to build because it couldn't find libgfortran

I fixed it by running

```
LIBRARY_PATH=/usr/local/Cellar/gcc/6.3.0_1/lib/gcc/6 cargo build --release
```
