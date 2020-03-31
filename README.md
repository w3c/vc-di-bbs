# jsonld-signatures-bbs-spec

BBS+ is a pairing-based cryptographic signature used for signing 1 or more messages. As described in the [BBS+ spec](https://eprint.iacr.org/2016/663.pdf),
BBS+ keys function in the following way:

1. A a prime field *&integers;<sub>p</sub>*
1. A bilinear pairing-friendly curve *E* with three groups *&#x1D53E;<sub>1</sub>, &#x1D53E;<sub>2</sub>, &#x1D53E;<sub>T</sub>* of prime order *p*.
1. A type-3 pairing function *e* such that *e :  &#x1D53E;<sub>1</sub> X &#x1D53E;<sub>2</sub> &xrarr; &#x1D53E;<sub>T</sub>*.  More requirements for this can be found in section 4.1 in the [BBS+ spec](https://eprint.iacr.org/2016/663.pdf)
1. A base generator *g<sub>1</sub> &isin; &#x1D53E;<sub>1</sub>* for curve *E*
1. A base generator *g<sub>2</sub> &isin; &#x1D53E;<sub>2</sub>* for curve *E*
1. *L* messages to be signed
1. **Key Generation**
    1. Inputs (*L*)
    1. Generate a random generator for each message *(h<sub>1</sub>, ... , h<sub>L</sub>) &xlarr; &#x1D53E;<sub>1</sub><sup>L+1</sup>*
    1. Generate a random generator used for blinding factors *h<sub>0</sub> &xlarr; &#x1D53E;<sub>1</sub>*
    1. Generate random *x &xlarr; &integers;<sub>p</sub>*
    1. Compute *w &xlarr; g<sub>2</sub><sup>x</sup>*
    1. Secret key is *x* and public *p<sub>k</sub>* is *(w, h<sub>0</sub>, h<sub>1</sub>, ... , h<sub>L</sub>)*
    1. Output (*p<sub>k</sub>*, *x*)
1. **Signature**
    1. Inputs (*p<sub>k</sub>, x, { M<sub>1</sub>, ... , M<sub>L</sub> }*)
    1. Each message *M* is converted to integers *(m<sub>1</sub>, ..., m<sub>L</sub>) &isin; &integers;<sub>p</sub>*
    1. Generate random numbers *&epsi;, s &xlarr; &integers;<sub>p</sub>*
    1. Compute *B &xlarr; g<sub>1</sub>h<sub>0</sub><sup>s</sup> &prod;<sub>i=1</sub><sup>L</sup> h<sub>i</sub><sup>m<sub>i</sub></sup>*
    1. Compute *A &xlarr;B<sup>1&frasl;<sub>x+&epsi;</sub></sup>*
    1. Output signature *&sigma; &xlarr; (A, &epsi;, s)*
1. **Verification**
    1. Inputs *(p<sub>k</sub>, &sigma;, { M<sub>1</sub>, ..., M<sub>L</sub> })*
    1. Each message *M* is converted to integers *(m<sub>1</sub>, ..., m<sub>L</sub>) &isin; &integers;<sub>p</sub>*
    1. Check *e(A, wg<sub>2</sub><sup>&epsi;</sup>) &#x225f; e(B, g<sub>2</sub>)*
1. **Zero-Knowledge Proof Generation**
    1. To create a signature proof of knowledge where certain messages are disclosed and others remain hidden
    1. *A<sub>D</sub>* is the set of disclosed attributes
    1. *A<sub>H</sub>* is the set of hidden attributes
    1. Inputs *(p<sub>k</sub>, A<sub>D</sub>, A<sub>H</sub>, &sigma;)*
    1. Generate random numbers *r<sub>1</sub>, r<sub>2</sub> &xlarr; &integers;<sub>p</sub>*
    1. Compute *B* as done in the signing phase
    1. Compute *A' &xlarr; A<sup>r<sub>1</sub></sup>*
    1. Compute *A&#773; &xlarr; A'<sup>-&epsi;</sup>B<sup>r<sub>1</sub></sup>*
    1. Compute *d &xlarr; B<sup>r<sub>1</sub></sup>h<sub>0</sub><sup>-r<sub>2</sub></sup>*
    1. Compute *r<sub>3</sub> &xlarr; 1&frasl;<sub>r<sub>1</sub></sub>*
    1. Compute *s' &xlarr; s - r<sub>2</sub> r<sub>3</sub>*
    1. Compute *&pi;<sub>1</sub> &xlarr; A'<sup>-&epsi;</sup> h<sub>0</sub><sup>r<sub>2</sub></sup>*
    1. Compute for all hidden attributes *&pi;<sub>2</sub> &xlarr; d<sup>r<sub>3</sub></sup>h<sub>0</sub><sup>-s'</sup>&prod;<sub>i=1</sub><sup>A<sub>H</sub></sup> h<sub>i</sub><sup>m<sub>i</sub></sup>
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
