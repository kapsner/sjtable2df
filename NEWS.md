

# sjtable2df NEWS

## Unreleased (2026-01-18)

#### CI

-   updated gha
    ([8f28a7c](https://github.com/kapsner/sjtable2df/tree/8f28a7c5389d27b3e674b83438f7e021468b4404))

#### Other changes

-   bump to v0.0.5
    ([5556641](https://github.com/kapsner/sjtable2df/tree/5556641efa252d603815985fa1cbc6ac3982e756))
-   added pre-commit hooks
    ([b48c506](https://github.com/kapsner/sjtable2df/tree/b48c50618674ef451a9d6563f03cba565f1af4d8))
-   updated dev-version
    ([4200d82](https://github.com/kapsner/sjtable2df/tree/4200d821d814687cb96ad3e83824ab279bc34996))

Full set of changes:
[`v0.0.4...5556641`](https://github.com/kapsner/sjtable2df/compare/v0.0.4...5556641)

## v0.0.4 (2025-04-04)

#### Bug fixes

-   fixing cran issue related to using testthat::expect_snapshot_value
    ([86733f8](https://github.com/kapsner/sjtable2df/tree/86733f8791adcf136de8f64b3b29c22762661fd7))

#### CI

-   updated gha
    ([3fe42b3](https://github.com/kapsner/sjtable2df/tree/3fe42b37a5579008af4981f841fc299a30674cfe))

#### Other changes

-   transition to quarto as vignette engine
    ([2872d3d](https://github.com/kapsner/sjtable2df/tree/2872d3db0e5af9ba81b64f8efe9fe414fba3a59d))
-   moving to automated readme
    ([e9470b0](https://github.com/kapsner/sjtable2df/tree/e9470b01f64e58dbe8a5ec39fc24be95a2dc2810))
-   merged into development
    ([7cca3a4](https://github.com/kapsner/sjtable2df/tree/7cca3a4940a5705cb7f39e79a29c372422bf5392))
-   updated dev version
    ([f78ab42](https://github.com/kapsner/sjtable2df/tree/f78ab4263ebb78043e947a1f120ddfaa56ba0a14))
-   updated news.md to v0.0.3
    ([3ad71ef](https://github.com/kapsner/sjtable2df/tree/3ad71ef2745eda99af6e1107b2d454245dc6bf60))

Full set of changes:
[`v0.0.3...v0.0.4`](https://github.com/kapsner/sjtable2df/compare/v0.0.3...v0.0.4)

## v0.0.3 (2023-04-13)

#### Bug fixes

-   stats to imports and setnames with pkg prefix
    ([04964a3](https://github.com/kapsner/sjtable2df/tree/04964a316b287bc06f7f28d1ad462fb7fe7fd031))

#### Refactorings

-   added checks for replacing values in last row of mtab
    ([b87ed08](https://github.com/kapsner/sjtable2df/tree/b87ed081754363df92e43d34c26590f3fc8e0fb4))
-   simplifying utf8 replacements
    ([2ba438e](https://github.com/kapsner/sjtable2df/tree/2ba438e0d5d1b31064d713277f4270f8120e0462))

#### CI

-   added dependency libgit2-dev to tic.yml
    ([3c47e51](https://github.com/kapsner/sjtable2df/tree/3c47e51bbea5797317e74b8ead0409d4411493c0))
-   devtools dependencies to tic.r
    ([9b75143](https://github.com/kapsner/sjtable2df/tree/9b75143c747a36bdb2f86c1c6c804319def85b5f))
-   updated lint-stage
    ([300723b](https://github.com/kapsner/sjtable2df/tree/300723b096f51c3bb06940bcc1ab49a2362f5c20))
-   updated gha
    ([82b3a66](https://github.com/kapsner/sjtable2df/tree/82b3a66a857688c4328dcf653b3985248c5888ec))

#### Docs

-   importfrom statements to zzz.r
    ([82edec9](https://github.com/kapsner/sjtable2df/tree/82edec9d5944df36a2433826072511b33141c0e3))

#### Other changes

-   updated metadata and news.md
    ([612032b](https://github.com/kapsner/sjtable2df/tree/612032b549d147f765251ff11086f87344529462))
-   more informative error messages in stopifnot statements
    ([08e5f3f](https://github.com/kapsner/sjtable2df/tree/08e5f3f298e1b5819c4544fd82480661f411b3d7))
-   fixed cran checks url
    ([772587e](https://github.com/kapsner/sjtable2df/tree/772587ebc4bdd4c2644c8d49ab410d126255a0b9))
-   merge main
    ([42f5f44](https://github.com/kapsner/sjtable2df/tree/42f5f44410c3158b9254521d07d3419caaebcfd9))
-   remove double significance information
    ([78aaf33](https://github.com/kapsner/sjtable2df/tree/78aaf33817e8dcd8a8b477320b27e35fdf06fd76))
-   updated news.md
    ([e5b2ddf](https://github.com/kapsner/sjtable2df/tree/e5b2ddf8ecd7b42511ef3fbf90229a77fafc2ceb))
-   merged development into main
    ([ce2227a](https://github.com/kapsner/sjtable2df/tree/ce2227a21bd3f3548916c773f775dc5ead776927))
-   changelog now with autonewsmd
    ([d502b46](https://github.com/kapsner/sjtable2df/tree/d502b462f36dcb130d660674206037c13dda9574))
-   changelog now with autonewsmd
    ([5a32908](https://github.com/kapsner/sjtable2df/tree/5a3290865b1a9f189ebe81f83d4d7a132ac2a617))
-   updated vignette name; added cran-installation to readme
    ([fc1faf4](https://github.com/kapsner/sjtable2df/tree/fc1faf416482bed9ea39f595eedd894e5dddc0ed))

Full set of changes:
[`v0.0.2...v0.0.3`](https://github.com/kapsner/sjtable2df/compare/v0.0.2...v0.0.3)

## v0.0.2 (2022-06-20)

#### Bug fixes

-   working on utf8 fix for windows
    ([6e36249](https://github.com/kapsner/sjtable2df/tree/6e36249f725f6e61771bd39bf90aca55923ff2f8))
-   updated logic to use read_html
    ([1582bc1](https://github.com/kapsner/sjtable2df/tree/1582bc18b7820391c75b7b8896e7c6bf447f5300))

#### Tests

-   added more unit tests with snapshots!
    ([beab215](https://github.com/kapsner/sjtable2df/tree/beab215e64b5b9fd72dfbba02d1eaa57dd6f906b))

#### CI

-   updated gha
    ([fcda225](https://github.com/kapsner/sjtable2df/tree/fcda2258aef638af6b107c32cb27a6ff7a969f92))

#### Docs

-   added readme; some other refactorings
    ([20be826](https://github.com/kapsner/sjtable2df/tree/20be826f7508732a9876f01a3ec148a071bb66b1))
-   updated return values
    ([521ce9b](https://github.com/kapsner/sjtable2df/tree/521ce9b35c26f2bec98ada664f8d0707a2d8e5d6))

#### Other changes

-   updated news.md
    ([cdd03a7](https://github.com/kapsner/sjtable2df/tree/cdd03a79fb8bb8d90d333da76466689bbbcbd7b3))
-   fixed formatting of lintr-file
    ([b88df55](https://github.com/kapsner/sjtable2df/tree/b88df551cbac6fe46c38f348d2802218c21fa9a3))
-   merging into main
    ([ae8ffc5](https://github.com/kapsner/sjtable2df/tree/ae8ffc53f75e6a38372e5654ac2525152040ee5a))
-   updated lintr
    ([c7823a2](https://github.com/kapsner/sjtable2df/tree/c7823a2c5598158603765ff2357ea4c51e9b564c))
-   fixed badge url
    ([4eae523](https://github.com/kapsner/sjtable2df/tree/4eae523c3d8246649cd034011ceecf6bb89311c4))
-   updated description and news.md
    ([550db85](https://github.com/kapsner/sjtable2df/tree/550db85ce75ae08c1b5902315ef5301b9e392a76))
-   fixed missing whitespace
    ([7a40408](https://github.com/kapsner/sjtable2df/tree/7a404088942eb9463ead3d6f63a547d51f833efb))
-   added news.md
    ([c9205d7](https://github.com/kapsner/sjtable2df/tree/c9205d775a889d4ca55e58a4530b3646f41d40a7))

Full set of changes:
[`v0.0.1...v0.0.2`](https://github.com/kapsner/sjtable2df/compare/v0.0.1...v0.0.2)

## v0.0.1 (2021-12-20)

Full set of changes:
[`e4e9992...v0.0.1`](https://github.com/kapsner/sjtable2df/compare/e4e9992...v0.0.1)
