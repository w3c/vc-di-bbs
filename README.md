# jsonld-signatures-bbs-spec

BBS+ is a pairing-based cryptographic signature used for signing 1 or more messages. As described in the [BBS+ spec](https://eprint.iacr.org/2016/663.pdf),
BBS+ keys function in the following way:

1. A a prime field ![prime-field](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\mathbb{Z}_p^*)
1. A bilinear pairing-friendly curve `E` with three groups ![pairing-image](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\mathbb{G}_1,&space;\mathbb{G}_2,&space;\mathbb{G}_T) of prime order `p`.
1. A type-3 pairing function `e` such that ![pairing-function](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;e:\,&space;\mathbb{G}_1&space;\times&space;\mathbb{G}_2&space;\rightarrow&space;\mathbb{G}_T). More requirements for this can be found in section 4.1 in the [BBS+ spec](https://eprint.iacr.org/2016/663.pdf)
1. A base generator ![generator-g1](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;g_1&space;\in&space;\mathbb{G}_1) for curve `E`
1. A base generator ![generator-g2](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;g_2&space;\in&space;\mathbb{G}_2) for curve `E`
1. *L* messages to be signed
1. **Key Generation**
    1. Inputs ![keygen](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(L)&space;\rightarrow&space;(p_k,&space;x)")
    1. Generate a random generator for each message ![message-generators](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(h_1,\dots,h_L)\overset{_\$}{\leftarrow}\mathbb{G}_1^{L&plus;1})
    1. Generate a random generator used for blinding factors ![blinding-generator](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;h_0\overset{_\$}{\leftarrow}\mathbb{G}_1})
    1. Generate random ![secret-key](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;x&space;\overset{_\$}{\leftarrow}&space;\mathbb{Z}_p^*)
    1. Compute ![commitment-secret](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;w\leftarrow&space;g_2^x)
    1. Secret key is `x` and public `pk` is ![pk](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(w,h_0,h_1,\dots,h_L))
    1. Output (`pk`, `x`)
1. **Signature**
    1. Inputs ![sig-api](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(p_k,&space;x,&space;\{m_1,\dots,m_L\})&space;\rightarrow&space;\sigma)
    1. Each message is converted to be integers ![messages](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(m_1,\dots,m_L)&space;\in&space;\mathbb{Z}_p)
    1. Generate random numbers ![sign-nums](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;e,s&space;\overset{_\$}{\leftarrow}&space;\mathbb{Z}_p)
    1. Compute ![b-sig](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;B&space;\leftarrow&space;g_1&space;h_0^s&space;\prod_{i=1}^{L}h_i^{m_i})
    1. Compute ![a-sig](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;A\left(&space;\leftarrow&space;B\right&space;)^{\frac{1}{x&plus;e}})
    1. Output signature ![siganture](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\sigma&space;\leftarrow&space;(A,&space;e,&space;s))
1. **Verification**
    1. Check ![verify-sig](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;e(A,wg_2^e)&space;\overset{?}{=}&space;e(g_1h_0^s\prod_{i=1}^{L}{h_i^{m_i}},g_2))
1. **Zero-Knowledge Proof Generation**
    1. To create a signature proof of knowledge where certain messages are disclosed and others remain hidden
    1. Generate random numbers ![proof-rand](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;r_1,r_2&space;\in&space;\mathbb{Z}_p^*)
    1. Compute `B` as done in the signing phase
    1. Compute ![a-prime](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;A'&space;\leftarrow&space;A^{r_1})
    1. Compute ![a-bar](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\overline{A}&space;=&space;A'^{-e}B^{r_1})
    1. Compute ![proof-d](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;d&space;=&space;B^{r_1}h_0^{-r_2})
    1. Compute ![r-3](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;r_3&space;\leftarrow&space;\frac{1}{r_1})
    1. Compute ![s-prime](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;s'&space;\leftarrow&space;s&space;-&space;r_2&space;r_3)
    1. Compute ![proof1](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\theta&space;\leftarrow&space;A'^{-e}&space;h_0^{r_2})
    1. Compute for all hidden attributes (for example m1 and m2) ![hidden-atts](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\lambda&space;\leftarrow&space;d^{r_3}&space;h_0^{-s'}&space;h_1^{-m_1}&space;h_2^{-m_2})
    1. Revealed attributes (m3 and m4)
1. **Zero-Knowledge Proof Verification**
    1. Check signature ![verify-sig](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;e(A',&space;w)&space;\overset{?}{=}&space;e(\overline{A},&space;g_2))
    1. Check hidden attributes ![verify-hidden](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\overline{A}&space;/&space;d&space;\overset{?}{=}&space;\theta)
    1. Check revealed attributes ![verify-disclosed](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;\lambda&space;\overset{?}{=}&space;g_1&space;h_3^{m_3}&space;h_4^{m_4})

The BBS+ spec does not specify when the generators ![pk-generators](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(h_0,\dots,h_L)),
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

1. **Key Generation**
    1. Inputs ![keygen-api](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;()&space;\rightarrow&space;(w,&space;x))
    1. Generate random ![secret-key](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;x&space;\overset{_\$}{\leftarrow}&space;\mathbb{Z}_p^*)
    1. Compute ![commitment-secret](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;w\leftarrow&space;g_2^x)
    1. Secret key is `x` and public `pk` is `w`
    1. Output (`pk`, `x`)
1. **Signature**
    1. Inputs ![sig-api](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(x,&space;\{m_1,\dots,m_L\})&space;\rightarrow&space;\sigma)
    1. Each message is converted to be integers ![messages](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;(m_1,\dots,m_L)&space;\in&space;\mathbb{Z}_p)
    1. Compute ![commitment-secret](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;w\leftarrow&space;g_2^x)
    1. Compute message specific generators by doing the following:
        1. `H2C` is the hash to curve algorithm
        1. I2OSP and OS2IP: These functions are used to convert a byte string to and from a non-negative integer as described in [RFC8017](https://tools.ietf.org/html/rfc8017).
        1. Compute ![h_0](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;h_0&space;\leftarrow&space;H2C(w&space;||&space;I2OSP(0,&space;1)&space;||&space;I2OSP(L,&space;4)&space;))
        1. Compute ![h_i](https://latex.codecogs.com/gif.latex?\dpi{120}&space;\fn_jvn&space;\large&space;h_i&space;\leftarrow&space;H2C(w&space;||&space;I2OSP(0,&space;1)&space;||&space;I2OSP(L,&space;4)&space;||&space;I2OSP(0,&space;1)&space;||&space;I2OSP(i,&space;1)&space;||&space;I2OSP(0,&space;1)&space;||&space;I2OSP(i&space;&plus;&space;1,&space;1)&space;||&space;\dots))
