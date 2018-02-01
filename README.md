# Set Android Manifest Values

This is a Bitrise step that sets some important Android manifest values.

- package
- label
- android:versionCode
- android:versionName

It performs the setting of values by using [xmlstarlet](http://xmlstar.sourceforge.net/) via the bash shell; not string replacement.

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`
