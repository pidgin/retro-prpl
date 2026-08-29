# Retro Protocol Plugins

This repository contains all of the proprietary protocol plugins that were
ever included in Gaim/Pidgin.

There are many goals of this repository including being able to use any of
them with modern versions of Pidgin 2. We are unlikely to ever port these to
Purple 3 but if someone wants to do that, they can feel free assuming they
follow the licenses.

Most of these protocols have little if any documentation to how they work. By
preserving them in this repository it is much easier for people to study them.

Also there has been a lot of interest in creating clones of old chat networks.
Projects like [Open OSCAR Server](https://github.com/mk6i/open-oscar-server),
[escargot](https://escargot.chat/), and [NINA](https://nina.chat/) all do this
to different extents.

## Why now?

Many people have asked us about bringing back our old protocols so that they
can use Pidgin on these networks. Initially we rejected this idea as this code
hasn't been maintained in years and may potentially have security issues.

However, we realized that if we don't support these protocol plugins others
may do so and when people need support they'll most likely look to us. While
this should be fine, it could take a while to figure out exactly what's going
on, especially if there are multiple versions out there.

To avoid all of this, we decided we would get everything setup in a fashion
that is low maintenance for us but makes it easy for people to contribute in
a way that everyone can win.

## A few things to think about when using the retro protocol plugins

When it comes to the clone networks, the protocols may be the same ones used
years ago but these are not the same networks. Your friends from way back when
are not on these networks as these are completely separate implementations and
your data on the official networks was lost when they shut them down.

Likewise, you are unlikely to be able to hold the operators of these networks
accountable unless you personally know them. This means you should be very
careful about what you share on these networks as they can see everything that
is happening on them including the messages you send.

# Discussion

A discussion forum is available on the [Instant Messaging Freedom
Discourse](https://discourse.imfreedom.org/t/about-the-retro-prpl-category/308).

# Installing

We are currently in the process of getting builds together but right now only
have a handful of packages available.

## Windows

You can find the latest installer on the [latest
releases](https://github.com/pidgin/retro-prpl/releases/latest) page. It is
named `retro-prpl-<VERSION>.exe`. Downloading and running this will guide you
through the installation process. Note you must already have Pidgin installed.

## Arch Linux

[Marius Orcsik](https://marius.federated.id/) put together an [AUR
package](https://aur.archlinux.org/packages/retro-prpl-git).

## Everything Else

For everything else you will have to build it yourself.

retro-prpl uses [The Meson Build system](https://mesonbuild.com/) as a build
system.

It is a pretty simple, but before building you're going to need some
dependencies.

| Package | Debian | Fedora | macOS (brew) |
| ------- | ------ | ------ | ------------ |
| gettext | gettext | gettext | gettext |
| libpurple | libpurple-dev | libpurple-devel | pidgin |
| libgadu[^1] | libgadu-dev | libgadu-devel | libgadu |
| libmeanwhile[^2] | libmeanwhile-dev | meanwhile-devel | *not available* |
| meson | meson | meson | meson |
| ninja | ninja-build | ninja-build | ninja |

We do not call out a C compiler to use, but we do test with GCC and Clang.

By default everything will be installed into the expected paths from your
libpurple install which can be messy if you're using a system package. You can
change this by passing `-Duse-purple-prefix=false` to `meson setup`.

There are also options to enable or disable any protocol provided. You can see
the full list of these and all other configuration settings by running
`meson configure` in the root of the source directory.

Once you have all your dependencies and options figured out, the build is just
like any other Meson project.

```
meson setup build
cd build
ninja
ninja install
```

If you have Pidgin or another libpurple client running, you'll need to restart
it for the plugins to get loaded.

[^1]: retro-prpl carries an internal version of this which will be used if a
system-wide version is not found.
[^2]: This is an optional dependency that will just disable the feature if it
is not available.
