# CHANGELOG

## 1.0.1 -- 2023-09-08

### Added

- Test guards.
- Test CLI module.

### Changed

- Remove code that maps PAN starting with 65 to :rupay.
  PAN starting with 65 is Discover.

- CI changes:
  - Elixir 1.14.5
  - OTP 25.3.2.5
  - Add Elixir 1.15.5
  - Add OTP 26.0.2

- Code Quality Changes (Adopting Elixir):
  - Credo config
  - Document dialyzer
  - InchEx
  - ExCoveralls
  - Sobelow

- Update dependencies:
  - `dialyxir`
  - `ex_doc`

## 1.0.0 -- 2023-08-08

Publish

### Added

- CLI for `card_brand/2`.
- Add GitHub workflow.

## 0.3.0 - 2023-08-08

### Added

- Add README and CHANGELOG to Hex docs.
- Add pre-commit tasks.
- Add command-line interface.

### Changed

- Return reason tuple on error.
  - `{:error, {:pan_too_short,"Minimum PAN length is 12, found 10."}}`
  - `{:error, {:pan_unknown,"Unknown card brand."}}`
  - `{:error, {:pan_too_long, "Maximum PAN length is 19, found 20."}}`
- Replace Erlang binary/bytes types with String.t in @spec's.

## 0.2.0 - 2023-08-07 WIP

### Added

- Brands: Dankort, GPN, LankaPay, Troy, UkrCard, Verve.
  - Brands are now complete.
- In-line document tests.
- Generate documentation.

### Changed

- Correct major error of `card_brand/1` passing CodePoints to `card_brand/2`.
- Identify PAN starting just 65 as Discover, vs. RuPay or Troy.
- Minor credo refactors.

## v0.1.0 - 2023-08-05 WIP

### Added

- Add guards to `card_brand`.
- Rough move to mix project, tests are functional.

## v0.0.3 - 2023-08-04 WIP

### Added

- Make `pan_length` first parameter of `pan_range`.
- China UnionPay, China T-Union, Diners Club, Diners Club International
- JCB, Maestro, Maestro UK, Visa Electron
- BORICA, Humo, InstaPayment, InterPayment, Mir, Napas, UATP, UzCard

## v0.0.2 - 2023-08-03 WIP

- Initial release.

### Added

- American Express, Discover, Mastercard, and Visa.
