# jsonld-signatures-bbs-spec

BBS+ is a pairing-based cryptographic signature used for signing 1 or more messages. As described in the [BBS+ spec](https://eprint.iacr.org/2016/663.pdf),
BBS+ keys function in the following way:

1. A a prime field &integers;<sub>p</sub>
1. A bilinear pairing-friendly curve `E` with three groups &#x1D53E;<sub>1</sub>, &#x1D53E;<sub>2</sub>, &#x1D53E;<sub>T</sub> of prime order `p`.
1. A type-3 pairing function `e` such that `e : ` &#x1D53E;<sub>1</sub> `X` &#x1D53E; &xrarr; &#x1D53E;<sub>T</sub>.  More requirements for this can be found in section 4.1 in the [BBS+ spec](https://eprint.iacr.org/2016/663.pdf)
1. A base generator ![generator-g1](img/generator-g1.png) for curve `E`
1. A base generator ![generator-g2](img/generator-g2.png) for curve `E`
1. *L* messages to be signed
1. **Key Generation**
    1. Inputs ![keygen](img/keygen.png)
    1. Generate a random generator for each message ![message-generators](img/message-generators.png)
    1. Generate a random generator used for blinding factors ![blinding-generator](img/blinding-generator.png)
    1. Generate random ![secret-key](img/secret-key.png)
    1. Compute ![commitment-secret](img/commitment-secret.png)
    1. Secret key is `x` and public `pk` is ![pk](img/pk.png))
    1. Output (`pk`, `x`)
1. **Signature**
    1. Inputs ![sig-api](img/sig-api.png)
    1. Each message is converted to be integers ![messages](img/messages.png)
    1. Generate random numbers ![sign-nums](img/sign-nums.png)
    1. Compute ![b-sig](img/b-sig.png)
    1. Compute ![a-sig](img/a-sig.png)
    1. Output signature ![siganture](img/signature.png)
1. **Verification**
    1. Inputs ![verify-sig-inputs](img/verify-sig-inputs.png)
    1. Check ![verify-sig](img/verify-sig.png)
1. **Zero-Knowledge Proof Generation**
    1. **A<sub>D</sub>** is the set of disclosed attributes
    1. **A<sub>H</sub>** is the set of hidden attributes
    1. Inputs ![proof-gen-inputs]()
    1. To create a signature proof of knowledge where certain messages are disclosed and others remain hidden
    1. Generate random numbers ![proof-rand](img/proof-rand.png)
    1. Compute `B` as done in the signing phase
    1. Compute ![a-prime](img/a-prime.png)
    1. Compute ![a-bar](img/a-bar.png)
    1. Compute ![proof-d](img/proof-d.png)
    1. Compute ![r-3](img/r-3.png)
    1. Compute ![s-prime](img/s-prime.png)
    1. Compute ![proof1](img/proof1.png)
    1. Compute for all hidden attributes (for example m1 and m2) ![hidden-atts](img/hidden-atts.png)
    1. Revealed attributes (m3 and m4)
1. **Zero-Knowledge Proof Verification**
    1. Check signature ![verify-sig-proof](img/verify-sig-proof.png)
    1. Check hidden attributes ![verify-hidden](img/verify-hidden.png)
    1. Check revealed attributes ![verify-disclosed](img/verify-disclosed.png)

The BBS+ spec does not specify when the generators ![pk-generators](img/pk-generators.png)),
only that they are random generators. Generally in cryptography, public keys are created entirely during the key generation step. However,
Notice the only value in the public key `pk` that is tied to the private key `x` is `w`. 
If we isolate this value as the public key `pk`, this is identical to the [BLS signature keys](https://crypto.stanford.edu/~dabo/pubs/papers/BLSmultisig.html) or ECDSA. 
The remaining values could be computed at a later time, say during signing, verification, proof generation and verification.
This means key generation and storage is much smaller at the expense of computing the generators when they are needed.
Creating the remaining generators in this manner will require that all parties are able to arrive at the same values
otherwise signatures and proofs will not validate. In this Spec, we describe an efficient and secure method for
computing the public key generators on-the-fly.

## Proposal

In a prime field, any non-zero element in a prime order group generates the whole group, and ability to solve the discrete log relatively to a specific generator is equivalent to ability to solve it for any other.
As long as the generators are valid elliptic curve points, then any point should be secure. To compute generators,
we propose using IETF's [Hash to Curve](https://datatracker.ietf.org/doc/draft-irtf-cfrg-hash-to-curve/?include_text=1) algorithm which is also constant time combined with known inputs.
This method allows any party to compute generators that can be used in the BBS+ signature scheme.

## Algorithm

Using these changes, the API changes to be identical to ECDSA and BLS except signing and verification can include any number of messages vs a single message.

The API's change in the following way and compute the message specific generators by doing the following

1. `H2C` is the hash to curve algorithm
1. I2OSP: Thise function is used to convert a byte string to a non-negative integer as described in [RFC8017](https://tools.ietf.org/html/rfc8017).
1. Compute ![h_0-on-the-fly](img/h_0-on-the-fly.png)
1. Compute ![h_i-on-the-fly](img/h_i-on-the-fly.png)

1. **Key Generation**
    1. Inputs ![keygen-api](img/keygen-api.png)
    1. Generate random ![secret-key](img/secret-key.png)
    1. Compute ![commitment-secret](img/commitment-secret.png)
    1. Secret key is `x` and public `pk` is `w`
    1. Output (`pk`, `x`)
1. **Signature**
    1. Inputs ![sig-api2](img/sig-api2.png)
    1. Compute ![commitment-secret](img/commitment-secret.png)
    1. Compute message specific generators.
    1. Same as before
1. **Verification**
    1. Inputs ![]
    1. Compute message specific generators.
    1. Verify as before
