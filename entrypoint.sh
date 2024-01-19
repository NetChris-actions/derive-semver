#!/bin/sh -l

GitRef="$1"

# https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
# This is relaxed to find it the first time in a line
SemVer2RegEx="((0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)"

Version=$(echo $GitRef | pcre2grep $SemVer2RegEx)

semVer=$(echo $Version | pcre2grep -o1 $SemVer2RegEx)
majorVersion=$(echo $Version | pcre2grep -o2 $SemVer2RegEx)
minorVersion=$(echo $Version | pcre2grep -o3 $SemVer2RegEx)
patchVersion=$(echo $Version | pcre2grep -o4 $SemVer2RegEx)
preReleaseVersion=$(echo $Version | pcre2grep -o5 $SemVer2RegEx)
buildMetadata=$(echo $Version | pcre2grep -o6 $SemVer2RegEx)

MajorMinorRegEx="((0|[1-9]\d*)\.(0|[1-9]\d*))"
majorMinorOnly=$(echo $Version | pcre2grep -o1 $MajorMinorRegEx)

hasSemVer=false
isPreRelease=false

if [ ! -z "$semVer" ]
then
  hasSemVer=true

  if [ ! -z "$preReleaseVersion" ]
  then
    isPreRelease=true
  fi
fi

# echo "semVer=$semVer" >> $GITHUB_OUTPUT
# echo "majorVersion=$majorVersion" >> $GITHUB_OUTPUT
# echo "minorVersion=$minorVersion" >> $GITHUB_OUTPUT
# echo "patchVersion=$patchVersion" >> $GITHUB_OUTPUT
# echo "preReleaseVersion=$preReleaseVersion" >> $GITHUB_OUTPUT
# echo "buildMetadata=$buildMetadata" >> $GITHUB_OUTPUT
# echo "majorMinorOnly=$majorMinorOnly" >> $GITHUB_OUTPUT

echo "hasSemVer=$hasSemVer"
echo "semVer=$semVer"
echo "majorVersion=$majorVersion"
echo "minorVersion=$minorVersion"
echo "patchVersion=$patchVersion"
echo "preReleaseVersion=$preReleaseVersion"
echo "buildMetadata=$buildMetadata"
echo "majorMinorOnly=$majorMinorOnly"
echo "isPreRelease=$isPreRelease"
