# Derive SemVer version from git ref

Use this action to derive the SemVer version from `GITHUB_REF_NAME`.  Internally, this uses [`pcre2grep`](https://www.pcre.org/current/doc/html/pcre2grep.html) and [the official SemVer.org RegEx](https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string) to match values.

``` yml
name: Simplistic Example

on: [push]

jobs:
  some-job:
    runs-on: ubuntu-latest
    name: Some job that uses this action
    steps:
      - name: SemVer parse
        id: parse
        uses: NetChris-actions/derive-semver@v1
      - name: Output full match
        run: echo ${{ steps.parse.outputs.semVer }}
      - name: Output major
        run: echo ${{ steps.parse.outputs.majorVersion }}
      - name: Output minor
        run: echo ${{ steps.parse.outputs.minorVersion }}
      - name: Output patch
        run: echo ${{ steps.parse.outputs.patchVersion }}
      - name: Output prerelease
        run: echo ${{ steps.parse.outputs.preReleaseVersion }}
      - name: Output buildmetadata
        run: echo ${{ steps.parse.outputs.buildMetadata }}
      - name: Output majorMinorOnly
        run: echo ${{ steps.parse.outputs.majorMinorOnly }}
```