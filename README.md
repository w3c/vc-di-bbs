# jsonld-signatures-bbs

The following repository contains the specification for a [linked data signature](https://w3c-ccg.github.io/ld-proofs/) using the [BBS+ Signature Algorithm](https://eprint.iacr.org/2009/095.pdf) using [BLS12-381](https://tools.ietf.org/id/draft-yonezawa-pairing-friendly-curves-00.html#rfc.section.2.4) elliptic curve based key pairs.

Due to the properties of a [BBS+ Signatures](https://eprint.iacr.org/2009/095.pdf) a zero knowledge proof can be derived from the signature, whereby the party generating the proof can elect to selectively disclose statements from the originally signed payload.

## References

- [BLS12-381 For The Rest Of Us](https://hackmd.io/@benjaminion/bls12-381)
- [Pairing-based cryptography](https://en.wikipedia.org/wiki/Pairing-based_cryptography)
- [Exploring Elliptic Curve Pairings](https://vitalik.ca/general/2017/01/14/exploring_ecp.html)
- [BBS+ Signature Scheme](https://eprint.iacr.org/2009/095.pdf)
- [Anonymous Attestation Using the Strong Diffie Hellman Assumption Revisited](https://www.researchgate.net/publication/306347781_Anonymous_Attestation_Using_the_Strong_Diffie_Hellman_Assumption_Revisited)
- [Pairing Friendly Curves Draft RFC](https://tools.ietf.org/html/draft-irtf-cfrg-pairing-friendly-curves-01)