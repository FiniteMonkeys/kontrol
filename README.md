# Kontrol

> An exploration of control theory, using
> [Kerbal Space Program](https://www.kerbalspaceprogram.com).

## EXAMPLES

All examples require these mods to be added to Kerbal Space Program.

* kRPC

### "Samara" Series

The Samara vehicle is about as simple as possible -- an engine, tankage, legs, and a control core.

#### Samara-1

    mix run examples/samara/samara-1.exs

* test throttle control
* test load sensing on legs

#### Samara-2

    mix run examples/samara/samara-2.exs

* test throttle control
  * surface altitude to 10 meters
  * coast to max altitude (vertical velocity == 0 m/s)
  * hover for 10 seconds
  * descend at 1 m/s until landing

#### Samara-(n)

* test inertial navigation system
* telemetry:
  * velocity vector
  * direction vector
  * heading (0..360)
  * pitch (-90..90)
  * roll (-180..180)

### "Hadi" Series

The Hadi vehicle is an upgrade to Samara, adding three RCS thruster blocks and a monopropellant tank.
