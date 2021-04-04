# BBS+ Signature Linked Data Proofs

[Latest Draft](https://w3c-ccg.github.io/ldp-bbs2020)

The following repository contains the specification for a [linked data signature](https://w3c-ccg.github.io/ld-proofs/) using the [BBS+ Signature Algorithm](https://mattrglobal.github.io/bbs-signatures-spec/) using [BLS12-381](https://tools.ietf.org/id/draft-yonezawa-pairing-friendly-curves-00.html#rfc.section.2.4) elliptic curve based key pairs.

Due to the properties of a [BBS+ Signatures](https://mattrglobal.github.io/bbs-signatures-spec/) a zero knowledge proof can be derived from the signature, whereby the party generating the proof can elect to selectively disclose statements from the originally signed payload.

## Reference Implementations

The following is a list of known reference implementations of this specification

- [jsonld-signatures-bbs](https://github.com/mattrglobal/jsonld-signatures-bbs) (Typescript + Rust)
- [aries-framework-go](https://github.com/hyperledger/aries-framework-go) (Golang)
