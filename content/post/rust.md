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
brew link --force openssl
```

Answer came from [here](https://github.com/sfackler/rust-openssl/issues/255#issuecomment-145092826))
