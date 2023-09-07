# Simple Card Brand

Determine a payment card's brand from the leading digits and length of the account number (PAN).

Uses the rules documented on [Wikipedia](https://en.wikipedia.org/wiki/Payment_card_number).

## Card Brands

- American Express (:americanexpress)
- BORICA (:borica)
- China T-Union (:chinatunion)
- China UnionPay (:chinaunionpay)
- Dankort (:dankort)
- Diners Club (:dinersclub)
- Diners Club International (:dinersclubinternational)
- Discover (:discover)
- GPN (:gpn)
- Humo (:humo)
- InstaPayment (:instapayment)
- InterPayment (:interpayment)
- JCB: (:jcb)
- LankaPay: (:lankapay)
- Maestro (:maestro)
- Maestro UK (:maestrouk)
- Mastercard (:mastercard)
- Mir (:mir)
- Napas (:napas)
- RuPay (:rupay)
- Troy (:troy)
- UATP (:uatp)
- UkrCard (:ukrcard)
- UzCard (:uzcard)
- Verve (:verve)
- Visa (:visa)
- Visa Electron (:visaelectron)

### Conflicts

The [Wikipedia](https://en.wikipedia.org/wiki/Payment_card_number) page has several account number range conflicts that need to be researched.

- 65 is always recognized as Discover.
  Overrides RuPay and Troy.

- 6759 is documented as both Maestro and Maestro UK.
  - Recognized as Maestro UK.

- 54 is documented as both Diners Club in the US and Mastercard.
  - Recognized as Diners Club.

## Mix Commands

- mix format
- mix test
- mix credo --strict

## Installation

TO DO

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `simplecardbrand` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:simplecardbrand, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/simplecardbrand>.

## Adopting Elixir

I'm using this project as a reference for various quality control tools.
As a result, there's a lot of code quality tools for such a small single-file module.
Using the [Adopting Elixir](https://www.kobo.com/us/en/ebook/adopting-elixir) recommendations.
