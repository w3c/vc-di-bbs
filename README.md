# BBS Data Integrity Cryptosuite

[Latest Draft](https://w3c.github.io/vc-di-bbs/)

This specification describes a
[Data Integrity Cryptosuite](https://www.w3.org/TR/vc-data-integrity/)
using the
[BBS Signature Scheme](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/)
using
[BLS12-381](https://datatracker.ietf.org/doc/draft-irtf-cfrg-pairing-friendly-curves/)
elliptic curve based key pairs.

Due to the properties of the
[BBS Signature Scheme](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/)
a zero knowledge proof can be derived from the signature, whereby the party
generating the proof can elect to selectively disclose statements from the
originally signed payload.

We encourage contributions meeting the
[Contribution Guidelines](CONTRIBUTING.md). While we prefer the creation of
issues and Pull Requests in the GitHub repository, discussions also occur on the
[public-vc-wg](http://lists.w3.org/Archives/Public/public-vc-wg/) mailing list.

## Verifiable Credentials Working Group

* Group page: [https://www.w3.org/2017/vc/WG/](https://www.w3.org/2017/vc/WG/)
* Charter: [https://www.w3.org/2022/06/verifiable-credentials-wg-charter.html](https://www.w3.org/2022/06/verifiable-credentials-wg-charter.html)
* Chairs
  * Brent Zundel - @brentzundel
* W3C Staff Contact
  * Ivan Herman - @iherman

### Other Relevant VC Working Group Repositories
* [Use Cases](https://www.w3.org/TR/vc-use-cases)
* [Data Model](https://www.w3.org/TR/vc-data-model)
* [Data Integrity](https://www.w3.org/TR/vc-data-integrity)

### Discussion Forums
* [W3C Credentials Community Group Mailing List (Incubation)](https://lists.w3.org/Archives/Public/public-credentials/)
* [W3C Verifiable Credentials WG Mailing List (Standardization)](https://lists.w3.org/Archives/Public/public-vc-wg/)

## Process Overview for Pull Requests
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
