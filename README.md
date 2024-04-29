<!-- SPDX-FileCopyrightText: 2024 FC (Fay) Stegerman <flx@obfusk.net> -->
<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

<!--

[![GitHub Release](https://img.shields.io/github/release/obfusk/apkrepotool.svg?logo=github)](https://github.com/obfusk/apkrepotool/releases)
[![PyPI Version](https://img.shields.io/pypi/v/apkrepotool.svg)](https://pypi.python.org/pypi/apkrepotool)
[![Python Versions](https://img.shields.io/pypi/pyversions/apkrepotool.svg)](https://pypi.python.org/pypi/apkrepotool)
[![CI](https://github.com/obfusk/apkrepotool/actions/workflows/ci.yml/badge.svg)](https://github.com/obfusk/apkrepotool/actions/workflows/ci.yml)
[![AGPLv3+](https://img.shields.io/badge/license-AGPLv3+-blue.svg)](https://www.gnu.org/licenses/agpl-3.0.html)

-->

# apkrepotool - manage APK repos

`apkrepotool` is a tool for managing APK repositories that can be used with an
F-Droid-compatible client; specifically, it generates v1 & v2 index JSON & JAR
files from a compatible directory structure with the required YAML metadata and
fastlane metadata & image files.

## Initial Setup

FIXME

NB: you probably don't want to accidentally commit your keystore and/or
passwords to git!  And please make sure you pay attention to the key properties
since you can't change the signing key later.

```bash
$ keytool -genkey -v -keystore keystore.jks -alias myrepo -keyalg RSA -keysize 4096 -sigalg SHA512withRSA -validity 10000
```

## CLI

```bash
$ apkrepotool update -v
Processing 'repo/catima-v2.26.0.apk'...
  'me.hackerchick.catima':131 ('2.26.0')
Processing 'repo/jiten-webview-1.0.3.apk'...
  'dev.obfusk.jiten_webview':202108010 ('1.0.3')
Processing 'metadata/dev.obfusk.jiten_webview.yml'...
Processing 'metadata/me.hackerchick.catima.yml'...
```

## Directory Structure

<details>

```
.
├── config.yml                          # main config file
├── metadata
│   ├── dev.obfusk.jiten_webview        # fastlane metadata
│   │   └── en-US
│   │       ├── full_description.txt
│   │       └── short_description.txt
│   ├── dev.obfusk.jiten_webview.yml    # app metadata
│   ├── me.hackerchick.catima           # fastlane metadata
│   │   ├── de-DE
│   │   │   ├── changelogs
│   │   │   │   ├── 131.txt
│   │   │   │   ├── 132.txt
│   │   │   │   └── 133.txt
│   │   │   ├── full_description.txt
│   │   │   ├── short_description.txt
│   │   │   └── title.txt
│   │   ├── en-US
│   │   │   ├── changelogs
│   │   │   │   ├── 131.txt
│   │   │   │   ├── 132.txt
│   │   │   │   └── 133.txt
│   │   │   ├── full_description.txt
│   │   │   ├── short_description.txt
│   │   │   └── title.txt
│   │   └── zh-TW
│   │       ├── full_description.txt
│   │       ├── short_description.txt
│   │       └── title.txt
│   └── me.hackerchick.catima.yml       # app metadata
└── repo
    ├── catima-v2.26.0.apk              # put APKs here
    ├── dev.obfusk.jiten_webview        # put images here
    │   └── en-US
    │       ├── featureGraphic.png
    │       ├── icon.png
    │       └── phoneScreenshots
    │           ├── 1.png
    │           ├── 2.png
    │           ├── 3.png
    │           ├── 4.png
    │           └── 5.png
    ├── index-v1.json                   # generated by apkrepotool
    ├── index-v2.json                   # generated by apkrepotool
    ├── jiten-webview-1.0.3.apk         # put APKs here
    └── me.hackerchick.catima           # put images here
        ├── de-DE
        │   └── featureGraphic.png
        ├── en-US
        │   ├── featureGraphic.png
        │   ├── icon.png
        │   └── phoneScreenshots
        │       ├── screenshot-01.png
        │       ├── screenshot-02.png
        │       ├── screenshot-03.png
        │       ├── screenshot-04.png
        │       ├── screenshot-05.png
        │       ├── screenshot-06.png
        │       ├── screenshot-07.png
        │       └── screenshot-08.png
        └── zh-TW
            └── featureGraphic.png
```

</details>

## Configuration Files

### config.yml

```yaml
# repo information
repo_url: https://example.com/fdroid/repo
repo_name: My Repo
repo_description: >-
  This is a repository of apps to be used with an F-Droid-compatible client.
  Applications in this repository are official binaries built by the original
  application developers.

# signing config
repo_keyalias: myrepo
keystore: /path/to/keystore.jks
keystorepass_cmd: cat /path/to/.keystorepass
keypass_cmd: cat /path/to/.keypass

# optional settings
apkrepotool_dir: /path/to/apkrepotool_dir
apksigner_jar: /path/to/apksigner.jar
java_home: /usr/lib/jvm/java-11-openjdk-amd64
```

### metadata/me.hackerchick.catima.yml

```yaml
Name: Catima
AllowedAPKSigningKeys: d405cd69ede4c22074c328fb825689a84ab3fca4b3fdf0b6cc1333af62c67eb3
```

## TODO

* [x] `index-v1.json`
* [x] `index-v2.json`
* [x] `entry.json`
* [x] `-vv` (show files processed?)
* [x] `timestamps.json`
* [x] keystore config (no passwds in yml)
* [x] signed & compressed JARs
* [x] `diffs/*.json`
* [x] CI
* [ ] icon
* [ ] README
* [ ] repo fingerprint, QR, ...
* [ ] `targetSdk=minSdk` if unset, `uses-permission-sdk-23`, ...
* [ ] aask opt-out
* [ ] `cache/apks.json`
* [ ] hashed graphics files
* [ ] advanced options (e.g. mirrors)
* [ ] more metadata (license, links, ...)
* [ ] get (XML) icons from APK
* [ ] transparency log (2x) + signature blocklist
* [ ] hooks for checks
* [ ] proper `repro-apk` `binres` release & dependency
* [ ] JSON schemas
* [ ] HSM support
* [ ] `apkcache.json` -> `timestamps.json` script
* [ ] "API" ?!
* [ ] ...

## Installing

<!--

### Using pip

```bash
$ pip install apkrepotool
```

-->

### From git

NB: this installs the latest development version, not the latest release.

```bash
$ git clone https://github.com/obfusk/apkrepotool.git
$ cd apkrepotool
$ pip install -e .
```

NB: you may need to add e.g. `~/.local/bin` to your `$PATH` in order to run
`apkrepotool`.

To update to the latest development version:

```bash
$ cd apkrepotool
$ git pull --rebase
```

## Dependencies

Python >= 3.8 + `click` + `ruamel.yaml` + `repro-apk`.

NB: AXML support isn't released yet, so for now you need the `binres` branch
from git for `repro-apk`.

### Debian/Ubuntu

```bash
$ apt install python3-pip python3-click python3-ruamel.yaml
$ pip install git+https://github.com/obfusk/reproducible-apk-tools.git@binres-20240211
```

## License

[![AGPLv3+](https://www.gnu.org/graphics/agplv3-155x51.png)](https://www.gnu.org/licenses/agpl-3.0.html)

<!-- vim: set tw=70 sw=2 sts=2 et fdm=marker : -->
