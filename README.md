# EnvironmentBinding

[![CI](https://github.com/Tunous/EnvironmentBinding/actions/workflows/main.yml/badge.svg)](https://github.com/Tunous/EnvironmentBinding/actions/workflows/main.yml) | [**Documentation**](https://tunous.github.io/EnvironmentBinding/documentation/environmentbinding/)

**Deprecated:** It is possible to natively achieve the same functionallity as this library provides by using both `@Envrionment` and `@Binding` property wrappers:

```swift
struct PlayButton: View {
    @Environment(\.isPlaying) @Binding var isPlaying

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }
    }
}
```

___

A property wrapper that reads a binding from a SwiftUI's view’s environment. It allows you to skip writing `.wrappedValue` when working with Bindings in environment.

## Usage

`EnvironmentBinding` property wrapper works with any non-optional `Binding` defined in `EnvironmentValues`.
For example if you define `isPlaying` environment value as follows:

```swift
private struct IsPlayingKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var isPlaying: Binding<Bool> {
        get { self[IsPlayingKey.self] }
        set { self[IsPlayingKey.self] = newValue }
    }
}
```

Then you can later access it from environment by passing `isPlaying` key path to `EnvironmentBinding`. That way you can access and modify the underlying value directly or get access to the binding through the $ symbol.

```swift
import EnvironmentBinding

struct PlayButton: View {
    @EnvironmentBinding(\.isPlaying) var isPlaying

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }
    }
}
```


## Installation

### Swift Package Manager

Add the following to the dependencies array in your "Package.swift" file:

```swift
.package(url: "https://github.com/Tunous/EnvironmentBinding.git", .upToNextMajor(from: "1.0.0"))
```

Or add https://github.com/Tunous/EnvironmentBinding.git, to the list of Swift packages for any project in Xcode.

## Credits

This package was inspired by [EnvironmentBinding article](https://lostmoa.com/blog/EnvironmentBinding/) from [NIL COALESCING LIMITED](https://nilcoalescing.com/about/).
