# 0.1.5

- Add `streams`, and `none` as options for di/statemanagement.
- Add `project_structure` for structuring of files, and directories organization in the project with `layer_first`, and `feature_first` options.
- Add support for generating methods that create url from path parameters and query parameters in a path of a screen

# 0.1.4+1

- Replace `state_notifier` import with `riverpod` in controller.

# 0.1.4

- Update file names in template to use a smaller path (Path length reduced upto 11-30%)

# 0.1.3

- Fix pre-gen hook ending with error.
- Add missing `@override` annotation in templates.
- Add simple tests for `pre-gen` hooks.
- You can disable generation of tests by using the `has_tests` variable.

# 0.1.2+1

- Update README.md

# 0.1.2

- Add InheritedTheme generation for widget schematic in the `pre_gen` hook.

# 0.1.1

- Update README
- Add widget as a schematic

# 0.1.0+1

- Add screen schematic generation
- Add service schematic generation
- Add riverpod for di with screen or service
- Add test generation for screen and service
