# BBS Data Integrity Cryptosuite

[Latest Draft](https://w3c-ccg.github.io/vc-di-bbs/)

This specification describes a
[Data Integrity Cryptosuite](https://www.w3.org/TR/vc-data-integrity/)
using the
[BBS+ Signature Algorithm](https://www.ietf.org/archive/id/draft-irtf-cfrg-bbs-signatures-02.html)
using
[BLS12-381](https://tools.ietf.org/id/draft-yonezawa-pairing-friendly-curves-00.html#rfc.section.2.4)
elliptic curve based key pairs.

Due to the properties of a
[BBS+ Signatures](https://www.ietf.org/archive/id/draft-irtf-cfrg-bbs-signatures-02.html)
a zero knowledge proof can be derived from the signature, whereby the party
generating the proof can elect to selectively disclose statements from the
originally signed payload.

We encourage contributions meeting the
[Contribution Guidelines](CONTRIBUTING.md). While we prefer the creation of
issues and Pull Requests in the GitHub repository, discussions also occur on the
[public-vc-wg](http://lists.w3.org/Archives/Public/public-vc-wg/) mailing list.

## Known Implementations

The following is a list of known implementations of this specification

- [jsonld-signatures-bbs](https://github.com/mattrglobal/jsonld-signatures-bbs) (Typescript + Rust)
- [aries-framework-go](https://github.com/hyperledger/aries-framework-go) (Golang)
- [go-bbs](https://github.com/suutaku/go-bbs) (Golang)

### Other Relevant Working Group Repositories
* [Use Cases](https://www.w3.org/TR/vc-use-cases)
* [Data Model](https://www.w3.org/TR/vc-data-model)
* [Data Integrity](https://www.w3.org/TR/vc-data-integrity)

### Discussion Forums
* [W3C Credentials Community Group Mailing List (Incubation)](https://lists.w3.org/Archives/Public/public-credentials/)
* [W3C Verifiable Credentials WG Mailing List (Standardization)](https://lists.w3.org/Archives/Public/public-vc-wg/)

## Process Overview for VC Data Model Pull Requests
1. Anyone can open a PR on the repository. Note that for the PR to be merged,
   the individual must agree to the
   [W3C Patent Policy](https://www.w3.org/Consortium/Patent-Policy/).
2. Once a PR is opened, it will be reviewed by the Editors and other WG
   Members.
3. The W3C CCG is automatically notified of PRs as they are raised and
   discussed.
4. PRs are usually merged in 7 days if there is adequate review and consensus,
   as determined by the Chairs and Editors.

### Roadmap for 2022-2024

The VCWG has a set of
[deliverables](https://www.w3.org/2022/06/verifiable-credentials-wg-charter.html#deliverables)
and a
[timeline](https://www.w3.org/2022/06/verifiable-credentials-wg-charter.html#timeline)
listed in the most recent
[VCWG charter](https://www.w3.org/2022/06/verifiable-credentials-wg-charter.html)
