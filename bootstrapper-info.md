# Flutter Bootstrapper
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

![Build](https://github.com/Dan-Incorporated/samsshack/actions/workflows/build.yml/badge.svg)
![Test](https://github.com/Dan-Incorporated/samsshack/actions/workflows/test.yml/badge.svg)
[![codecov](https://codecov.io/gh/Dan-Incorporated/samsshack/branch/master/graph/badge.svg?token=837V3AMFT6)](https://codecov.io/gh/Dan-Incorporated/samsshack)

#### By: [Daniel Nazarian](https://danielnazarian) 🐧👹
##### Contact me at <dnaz@danielnazarian.com>
##### Created using [Daniel's Flutter Bootstrapper](https://github.com/dan1229/samsshack)

-------------------------------------------------------

Flutter Bootstrapper - my take on a Flutter project template that I use for my projects.

Supports many of my basic workflows and designed to work well with my backend(s) of choice i.e.,
Django, and includes a number of utilities and tools to help build better, cleaner and faster
software.

Created with and for Flutter, written in Dart. Available for iOS, Android and Web.

## Setup
Pre requisites: Flutter (via [FVM](https://github.com/leoafarias/fvm)), SSH keys for Git, GitHub CLI
1. Run scripts/setup/initialize.sh to generate your project directory
2. Follow instructions printed at the end of the script - in the new project directory!!!




## Features
- Flutter via [FVM](https://github.com/leoafarias/fvm) support
  - iOS, Android and Web support out of the box
  - Sound null safety
- Project Skeleton (MVC)
  - This project is structured to (loosely) follow the [MVC](https://www.guru99.com/mvc-tutorial.html) pattern.
    This is explained more below.
- Store/State Management
  - Native `Store` management through `BaseState` powered by [Inherited Widget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
  - Support for certain 'special global variables' i.e., connection status, loading, etc.
  - Support for other state management solutions i.e., [BLoC](https://pub.dev/packages/flutter_bloc)
- Service Management and Templates
  - Management to ensure internal and external services are available throughout the app
  - Templates to standardize and speed up adding new APIs/services (Django backend only currently)
- Navigator 2.0 - implemented via [Routemaster](https://pub.dev/packages/routemaster)
- Basic Widgets
  - Basic pages
  - Forms and validation
  - Components (widgets) library
- VCS Setup (GitHub)
- CI/CD (GitHub Actions)
    - Code coverage provided by [CodeCov](https://app.codecov.io/gh)
    - Badges of course
- Testing Framework
  - Tests for bootstrapper components (95% or higher coverage)
- .env Integration and Environment Management
- Error Handling
    - Widget errors via error page
    - System/framework level errors
    - Email bug reports
- Dynamic Theme Switching
    - Light and dark theme support out of the box
- Favicons




## Architecture

### Base State
`BaseState` is
an [Inherited Widget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html). which is
simply an abstract widget meant to sit at the top of the widget tree i.e., the parent of every
widget, page, etc.

While not flawless for state management, this serves more than well enough to start with. If
building something more complex, you should at least consider a 'real' state management solution but
even then, I'd say `BaseState` stacks up well especially in terms of ease of use. Design may suffer
slightly bug 🤷‍.

Simply put: `BaseState` provides a way to store and access global elements like the `Store` and
other information e.g., a User model we may want available throughout the application.

**Note:** In order to use `BaseState`, you must ensure new pages/widgets inherit from `BaseState` instead of `State`.
You can still use `State` wherever you'd like and mix up these usages but you will not have access to any
other features/information provided by `BaseState`.

It's also important that instead of overriding the `build` method you now will want to override the `buildBase` method.


### Store
Whereas `BaseState` is the 'backend'/inner workings of how we get information around the app, the `Store` is intended to be the
'friendlier' way of interacting with these innards. The `Store` sits toward the top of our widget tree and contains a bunch of
important classes - `Navigator`, `HttpClient`, etc. - and 'top leve' methods like `logout`.

There isn't any real standard with this, `Store` in particular doesn't even need to be used but is a very helpful abstraction
especially if you decide to not use another state management solution.


### Service Manager
Simply a wrapper class in the `Store` to contain any services/APIs you'd like to hold in memory. While any service/API
can be used independently at a moments notice, if you'd like to store something 'longer term' this gives an easy
avenue to do so as well as easily manipulate multiple different APIs.

For example if you're pulling user related information from a REST API and want to store use it throughout
the application, you can store that API in the `ServiceManager` and it is then accessible anywhere.


### Navigation 2.0
You can use the typical Flutter navigation scheme to push and pop routes as appropriate. While effective in 99% of use cases,
this does fall short for some more complex routing. More importantly, it doesn't support deep linking and just in general
makes URL routing MUCH more difficult.

I include [Routemaster](https://pub.dev/packages/routemaster) to implement Navigator 2.0 (much
simpler than doing so ourselves). This provides links, proper navigation and more. To use it you
will need to store your routes in struc/routes.dart and do something like the following to navigate:

```
Routemaster.of(context).push(routeHome);
```

Where routeHome is a String defined in routes.dart.

### .env File / Environment Variables

It's **very** important to know that ultimately, this website will be completely static (and hosted
in some kind of file store) meaning that environment variables are always going to be potentially
exposed. I'd love to be proven wrong but to the best of my knowledge, some frameworks are able to
work around this depending on how you host them, currently, Flutter and particularly Flutter Web is
not.

The `.env` files (`.env.prod`, `.env.test`, etc.) are for you to set config in different
environments. These files are swapped at build time into the "main" `.env` file which is what is
used throughout the application.

This means it's **very important** to know that the `.env` files are **not secure** - they are
primarily for setting environment level flags, settings, etc. for different environments.

-------------------------------------------------------

##### [https://danielnazarian.com](https://danielnazarian.com)
##### Copyright 2021 © Daniel Nazarian.
