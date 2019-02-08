# Kontrol

> An exploration of control theory, using
> [Kerbal Space Program](https://www.kerbalspaceprogram.com).

## An introduction

### What is “control theory”?

Simply put, control theory is the math used to control a system whose state
is a function of time. More precisely, we’re interested in controlling the system
such that it is _stable_ (none of the values which compose the state grow to
infinity) and that when disturbed returns to a steady state without excessive
oscillation or damping.

Control theory covers a broad range of possible systems, so we’ll limit ourselves
to closed-loop (or _feedback_) control of a single state variable of a linear system.

### You use big words. How are you with metaphors?

Okay. Every closed-loop controller is made up of several parts.

  * The **system** being controlled
  * An **input** to the system, to change its state
  * An **output** from the system, to be measured
  * A reference value (the **set point**) against which the output is compared
  * The **error signal** (the difference between the measured output and the set point)
  * The **controller**, which converts the error signal to the output fed back into the system

For the **system**, think of your residence&mdash;your house, apartment,
parents’ basement, yurt, whatever. There are lots of **state variables** which
describe the time-dependent state of the system (temperature, humidity,
air pressure, to name just three). The controller will control only one state variable;
We'll call this one of interest the **process variable**.

We want to hold the temperature constant, so temperature is our **process variable**.
For the sake of the metaphor, assume that it’s winter where you are, so outside
of your residence is colder than the inside, so the temperature will drop over
time.

Some sensor, somewhere in your residence, measures the _current_ temperature. It is
compared to the _desired_ temperature (the **set point**); the difference between
the two is the **error value**.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `kontrol` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kontrol, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kontrol](https://hexdocs.pm/kontrol).
