# generate

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Generates files based on a schematic for organizing your project's structure.

With any generated schematic template, this generates simple di code, and tests to help you quickly expand your project.

This has the following schematic templates:

- screen
- service
- widget

## Getting Started 🚀

The generated code may depend on go_router, flutter_riverpod, riverpod, flutter_test (dev), or test (dev) packages. 

- Each screen has a private class with navigation information. This class contains a GoRoute declaration from go_router package for the screen. In future, this class will also have methods to create a path for navigating to this screen using path and query parameters.
- The providers of service and controllers use flutter_riverpod and riverpod packages.
- The tests that are generated use flutter_test and test packages.

## Table of Contents

- [How to use](#how-to-use-🚀)
  - [Model from Command Line](#command-line)
  - [Model from Config](#config)
- [Outputs](#outputs-📦)
  - [Screen](#screen)
  - [Service](#service)
  - [Widget](#widget)

## How to use 🚀

### Command Line

`mason make generate --schematic screen --name hello_world --di riverpod`

Then add your methods in the service! (Optional and available only for service)

## Variables for the Command Line ✨

| Variable      | Description                                                | Default                                   | Type     |
| ------------- | ---------------------------------------------------------- | ----------------------------------------- | -------- |
| `schematic`  | The schematic to generate                                      | screen (screen, service, widget)                                     | `enum` |
| `name` | The name of the schematic |      | `string`  |
| `di`       | The framework that will be used by components for di or state management                                         | riverpod (riverpod) | `enum`   |


### Config

`mason make generate -c generate_config.json`

[Example Config](https://github.com/predatorx7/mason_bricks/tree/main/bricks/generate/generate_config_template.json):

```json
{
  "schematic": "screen", // Could be screen, service, or widget
  "name": "hello world",
  "di": "riverpod" // Could be riverpod
}
```

## Variables for a Config ✨

| Variable      | Description                                                                    | Type     |
| ------------- | ------------------------------------------------------------------------------ | -------- |
| `schematic`  | The schematic to generate                                                          | `enum` |
| `name` | The name of the schematic                     | `string`  |
| `di`       | The framework that will be used by components for di or state management                                                             | `enum`   |

## Outputs 📦

### Screen

Creates a new, screen definition in the given project with controllers, providers, state, and tests.

```
--schematic screen --name hello_world --di riverpod
├── lib
│   └── screens
│       └── hello_world
│           ├── hello_world_controller.dart
│           ├── hello_world_provider.dart
│           ├── hello_world_screen.dart
│           ├── hello_world_state.dart
│           └── hello_world.dart
├── tests
│   └── screens
│       └── hello_world
│           └── hello_world_screen_test.dart
└── ...
```

[Example of a generated Screen](https://github.com/predatorx7/mason_bricks/tree/main/examples/generate)

### Service

Creates a new, generic service class definition in the given project with provider, abstract class, and tests.

```
--schematic service --name hello_world --di riverpod
├── lib
│   └── services
│       └── hello_world
│           ├── hello_world.dart
│           ├── hello_world_provider.dart
│           ├── hello_world_service.dart
│           └── hello_world_service_impl.dart
├── tests
│   └── services
│       └── hello_world
│           └── hello_world_service_test.dart
└── ...
```

[Example of a generated Service](https://github.com/predatorx7/mason_bricks/tree/main/examples/generate)

### Widget

Creates a new, generic widget definition in the given project with its inherited theme (optional), and tests.

```
--schematic widget --name hello_world --di riverpod
├── lib
│   └── widgets
│       └── hello_world
│           ├── hello_world_theme.dart
│           └── hello_world.dart
├── tests
│   └── widgets
│       └── hello_world
│           ├── hello_world_theme_test.dart
│           └── hello_world_test.dart
└── ...
```

[Example of a generated Widget](https://github.com/predatorx7/mason_bricks/tree/main/examples/generate)

<!-- - [Official Mason Documentation][2]
- [Code generation with Mason Blog][3]
- [Very Good Livestream: Felix Angelov Demos Mason][4]
- [Flutter Package of the Week: Mason][5]
- [Observable Flutter: Building a Mason brick][6]
- [Meet Mason: Flutter Vikings 2022][7]

[2]: https://docs.brickhub.dev
[3]: https://verygood.ventures/blog/code-generation-with-mason
[4]: https://youtu.be/G4PTjA6tpTU
[5]: https://youtu.be/qjA0JFiPMnQ
[6]: https://youtu.be/o8B1EfcUisw
[7]: https://youtu.be/LXhgiF5HiQg -->

[1]: https://github.com/felangel/mason

### Roadmap

- [ ] Support for go_router configs generation and updation when a screen is added
- [ ] Support for bloc as a di for screens or services
- [ ] Support for code generation for layer-first, or feature-first project structure.
