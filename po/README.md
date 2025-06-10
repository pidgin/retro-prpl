# Localization

Localization is meson is well documented in the [official
documentation](https://mesonbuild.com/Localisation.html).

Our `POTFILES` file is generated with the following command ran from the top
source directory:

```sh
find . -type f -iname '*.c'  | sort | cut -d / -f 2- > po/POTFILES
```
