# Simple Card Brand

## Note

- A work in progress August 2023.
- Not yet any tests so there may be regression errors as we work through brand recognition.

## Description

Determine a payment card's brand from the leading digits and length of the account number (PAN).

Uses the rules documented on [Wikipedia](https://en.wikipedia.org/wiki/Payment_card_number).

## Commands

- mix format
- mix test
- mix credo

## Installation

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

