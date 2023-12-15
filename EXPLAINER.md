# BBS Cryptosuite v2023 Explainer

## Editors

- Greg Bernstein
- Manu Sporny

## Participate

- [Issue tracker](https://github.com/w3c/vc-di-bbs/issues)
- [Discussion forum](https://lists.w3.org/Archives/Public/public-vc-wg/)

# Table of Contents

- [BBS Cryptosuite v2023 Explainer](#bbs-cryptosuite-v2023-explainer)
  - [Editors](#editors)
  - [Participate](#participate)
- [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Goals](#goals)
  - [Non-goals](#non-goals)
  - [User research](#user-research)
  - [What We're Trying to Accomplish](#what-were-trying-to-accomplish)
  - [How it Works](#how-it-works)
  - [Key scenarios](#key-scenarios)
    - [Selective Disclosure](#selective-disclosure)
    - [Unlinkability](#unlinkability)
  - [High-level Design discussion](#high-level-design-discussion)
    - [Verifiable Credential Processing for BBS](#verifiable-credential-processing-for-bbs)
  - [Considered alternatives](#considered-alternatives)
  - [Feedback](#feedback)
  - [Acknowledgements](#acknowledgements)

## Introduction

The *BBS Cryptosuite v2023* family specification describes a mechanism for
ensuring the authenticity and integrity of Verifiable Credentials and similar
types of constrained  digital documents using cryptography, especially through
the use of digital signatures and related mathematical proofs. It is one of several
cryptosuites within the
[VC Data Integrity](https://www.w3.org/TR/vc-data-integrity) framework.
This specification offers constant size signatures over multiple *messages*,
selective disclosure and unlinkable proofs.

## Goals

This specification allows *issuers*, *holders*, and *verifiers* to take
advantage of the cryptographic features of the [BBS signature scheme](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/). These include:

1. Constant sized signatures over an arbitrary number of *messages*. Size efficient verifiable credential (VC) data integrity from *issuer* to *holder*.
2. Selective disclosure of a subset of the original signed *messages*. Data minimization (privacy enhancement) for verifiable presentation (VP)  from *holder* to *verifier*
3. Unlinkability via "zero knowledge proof of knowledge of signature" for *holder* privacy when sending VPs to multiple *verifiers*. This feature can mitigate tracking in the presence of *verifier-verifier* or *verifier-issuer* collusion.

## Non-goals

Compatability with JWTs, JOSE, or COSE. There are other specifications that are
under development in the same WG that do that, such as VC-JWT.

Digitally signing experimental graph formats such as Labeled Property Graphs,
RDF-Star graphs, or other newer graph formats.

## User research

The work on Data Integrity started over a decade ago and has been incubated in
the W3C Credentials Community Group over that time period. We have performed a
number of interoperability plugfests over the years to test whether or not
developers find using the technology acceptable when they have a use case that
requires the features described in Data Integrity. These technologies have also
been deployed at scale in proof of concept, pilot, and production systems, in
retail point of sale solutions, in federal government systems, and
consumer-facing applications. The results of that research are continuously fed
back into future iterations of the work.

The desire for the *unlinkable* property of this scheme, while less known within
the context of digital signatures, is a well known and desirable privacy
property of concern in web browsers. See [Mitigating Browser Fingerprinting in
Web Specifications](https://www.w3.org/TR/fingerprinting-guidance/). In the
*privacy considerations* of this specification we provide an overall analysis
based on the *anonymity set* concept used in browser fingerprint analysis.

## What We're Trying to Accomplish

Provide standardization of the BBS signature scheme applied to verifiable
credentials to achieve the previously stated goals within the
[VC Data Integrity](https://www.w3.org/TR/vc-data-integrity) framework.

## How it Works

This specification defines a cryptographic suite for the purpose of creating,
verifying, and deriving proofs using the BBS Signature Scheme in conformance
with the Data Integrity specification. The BBS signature scheme directly
provides for selective disclosure and unlinkable proofs. It provides four
high-level functions that work within the issuer, holder, verifier model.
Specifically, an issuer uses the BBS Sign function to create a cryptographic
value known as a "BBS signature" which is used in signing the original
credential. A holder, on receipt of a credential signed with BBS, then verifies
the credential with the BBS Verify function.

The holder then chooses information to selectively disclose from the received
credential and uses the BBS ProofGen function to generate a cryptographic value,
known as a "BBS proof", which is used in creating a proof for this
"derived credential". The cryptographic "BBS proof" value is not linkable to the
original "BBS signature" and a different, unlinkable "BBS proof" can be
generated by the holder for additional "derived credentials", including any
containing the exact same information. Finally, a verifier uses the BBS
ProofVerify function to verify the derived credential received from the holder.

Applying the BBS signature scheme to verifiable credentials involves the
processing specified in this specification. In general the suite uses the RDF
Dataset Normalization Algorithm to transform an input document into its
canonical form. An issuer then uses selective disclosure primitives to separate
the canonical form into mandatory and non-mandatory statements. These are
processed separately with other information to serve as the inputs to the BBS
Sign function along with appropriate key material. This output is used to
generate a secured credential. A holder uses a set of selective disclosure
functions and the BBS Verify function on receipt of the credential to ascertain
validity.

Similarly, on receipt of a BBS signed credential, a holder uses the RDF Dataset
Normalization Algorithm to transform an input document into its canonical form,
and then applies selective disclosure primitives to separate the canonical form
into mandatory and selectively disclosed statements, which are appropriately
processed and serve as inputs to the BBS ProofGen function. Suitably processed,
the output of this function becomes the signed selectively disclosed credential
sent to a verifier. Using canonicalization and selective disclosure primitives,
the verifier can then use the BBS verifyProof function to validate the
credential.

## Key scenarios

### Selective Disclosure

When an entity protects a document, they might want to empower the receiver of
that document to share a subset of the document. This is called "selective
disclosure". This specification enables subsets of
documents to be shared while not breaking the digital signature on the subset of
the document that's shared.

### Unlinkability

Repeatedly sharing information in a document can create a correlation and
tracking risk. For example, repeatedly sharing a driver's license to prove that
one is above a certain age can lead to using the driver's license number to
track the individual. A more appropriate sharing would be to just share one's
age in a way that cannot be used to track the individual. Note that a digital
signature is unique enough to be used as a global tracking token, thus the need
for a digital signature that changes every time its presented while still
allowing the signature to be verified. This specification provides for
unlinkability via the use of "zero knowledge proof of knowledge of signatures"
as provided by the BBS signature scheme.

## High-level Design discussion

### Verifiable Credential Processing for BBS

The BBS signature scheme works with an ordered set of *messages*. The
[Data Integrity ECDSA Cryptosuites v1.0](https://w3c.github.io/vc-di-ecdsa/#ecdsa-sd-2023)
with its *selective disclosure* option provides mechanisms for taking a
verifiable credential and reducing it to an ordered set of *statements*. These
procedures are slightly modified as to preserve the desirable unlinkability
properties of the BBS signature scheme, i.e., removing or reducing artifacts
that can lead to correlation/tracking. Hence we maximally reuse existing
procedures while preserving the desirable properties of the BBS signature scheme.
See the *privacy considerations* section of the document for a full analysis of
data leakage and unlinkability.

## Considered alternatives

This is a cryptosuite for the data integrity that provides for selective
disclosure and unlinkable credentials. Currently the only signature scheme
undergoing standardization with these properties is the BBS signature scheme.

For an overview and background on BBS see the presentation from the DIF/IETF BBS
team to the NIST [Crypto Reading Club](https://csrc.nist.gov/csrc/media/presentations/2023/crclub-2023-10-18/images-media/20231018-crypto-club--greg-and-vasilis--slides--BBS.pdf).

## Feedback

There were 17 implementers that demonstrated interoperability on a subset of the
Data Integrity work:

https://docs.google.com/presentation/d/19GmJ3bLMrbVadesnkmsWaaUr-U71Y9Kr775tZvgs-xI/edit#

Additionally, the US Federal Government (DHS) has aligned their latest profile
for digital identity to use Verifiable Credentials and Data Integrity.

## Acknowledgements

