# Localization

Localization in meson is well documented in the [official
documentation](https://mesonbuild.com/Localisation.html).

Our `POTFILES` file is generated with the following command ran from the top
source directory:

```sh
git ls-files '*.c' | sort > po/POTFILES
```
