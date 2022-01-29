# SETUP for Sams Shack

#### By: [Daniel Nazarian](https://danielnazarian) 🐧👹

##### Contact me at <dnaz@danielnazarian.com>

##### Created using [Daniel's Flutter Bootstrapper](https://github.com/dan1229/samsshack)

-------------------------------------------------------

## Setup

1. Install FVM (check `README.md`) and Flutter.
2. Search through project "TODO"s. There's a few places marked "TODO" throughout the app (/lib),
   these include theme colors, names, CI/CD config, etc. that should be filled out ASAP. It's
   probably best to just ctrl+F these or grep or however you search best throughout the project
   directory.
3. App icons and favicons (web only) - instructions below
4. *** **IMPORTANT**: READ `bootstrapper-info.md` AND NOTES BELOW TO SETUP YOUR REPO AND DEPLOYMENT
   AS YOU WANT :))) ***
5. Fill out README.md!

   **WEB ONLY**

6. Update web/index.html web/manifest.json with information about your project like the title and
   description.
7. Web hosting - more information below.

## App Icons / Favicons

For mobile app icons for iOS and Android follow the instructions in `pubspec.yaml`.

If using web, you will also have to update the favicon images in the /web folder. The easiest way to
do this is to use a website like [favicon generator](https://www.favicon-generator.org/) and upload
a high resolution, square version of the image you would like to use as the favicon for this app.
Download the ZIP file of icons that the site generates for you and paste them in the `web/icons`
directory.

While updating the `web/icons` directory will do a majority of the work for favicons, you should
check/update
`web/index.html` as well to ensure it's accurate for your project.

## Web Hosting

Options:

- GitHub Pages
- S3 (COMING)

### GitHub Pages

**Prerequisite:** to use GitHub as your VCS you must have the [GitHub CLI](https://cli.github.com/)
installed To deploy to `GitHub Pages` you will need to do some manual config in the repo settings to
activate it first.

To activate GitHub Pages you will need to wait a few minutes for GitHub to do its thing then go to
the repo settings. Select the `gh-pages` branch as your source (`/root` as the directory.)
You will also need to update the 'base href' in `web/index.html` to include the repo name. This is
to ensure paths work with the non-root path GH Pages provides.

NOTE: `GitHub Pages` handles SPAs weirdly - primarily in that it won't redirect 404s to your
application. This is problematic for routing properly to your application. If this is the desired
behavior, please rename
`404-redirect.html` to `404.html` to override GitHub's 404 page and redirect the user back to your
application with the proper path (i.e., /about -> /#/about).

### S3

COMING

## CI/CD

### GitHub Runners

You should try to switch from GitHub hosted runners to self-hosted runners ASAP. This is accessible
via the repo settings in GitHub.

If your project is in an organization (
i.e., [Dan Incorporated](https://github.com/Dan-Incorporated)) just use the org's runners if
possible. Otherwise, projects will default to GitHub shared runners. To switch visit
the `.github/workflows/` directory and switch "self-hosted" with "ubuntu-latest" or vice versa.

### CI - builds and tests

All platforms (iOS, Android, Web) have CI scripts to test and build artifacts on every push. CI
should work relatively well out of the box via GitHub Actions however you may need to activate via
the repository settings.

**Mobile builds are disabled out of the box to save time and cost.**

You will most likely need to do some work to sign the Android builds in CI

- [something like this](https://blog.codemagic.io/the-simple-guide-to-android-code-signing/).

#### Code Coverage (CodeCov)

To get code coverage (and the badge) working properly, you must take a few extra steps.

1. Add the repo to your [CodeCov account](https://app.codecov.io/gh/) and activate it in the
   settings.
2. Once added, add the `Repository Upload Token` to GitHub secrets and name it `CODECOV_TOKEN`.
3. Go to the `badges` section of the settings to get your coverage badge markdown.
4. Next time your CI pipeline runs, it should auto upload to CodeCov and populate your badge(s).

### CD

#### Web

##### GitHub Actions

To deploy web via `GitHub Actions`, you will need to manually enable it in the repository on GitHub.
From there, uncomment the deploy script at `.github/workflows/deploy_web_prod.yml`. You may then
need to manually enable `GitHub Pages` in the repository settings and then GitHub CD script should
work as expected. Note CD scrips are all manually triggered by default.

#### Mobile

Automatic deployments for mobile are fairly difficult to setup through VCS (particularly for
free/cheap) but are **VERY** important!
Flutter works super well with [Fastlane](https://docs.fastlane.tools/) which can be installed for
Android and iOS. It also supports plugins for all sorts of useful features like automatic mobile
screenshots and similar.

**Note: CI/CD for iOS in particular can be very expensive - the cheapest route is to install a
GitHub Runner on a mac you own and use that device for builds/releases.**


-------------------------------------------------------

##### [https://danielnazarian.com](https://danielnazarian.com)

##### Copyright 2021 © Daniel Nazarian.
