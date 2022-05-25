import SwiftUI

/// A property wrapper that can read and write a value from a view's environment.
///
/// Use the ``EnvironmentBinding`` property wrapper to read and write a value stored in a view’s environment.
/// Indicate the binding to read using an `EnvironmentValues` key path in the property declaration. For example,
/// a button that toggles between play and pause can create a binding to an environment property of its parent view
/// using the ``EnvironmentBinding`` property wrapper.
///
/// ```swift
/// extension EnvironmentValues {
///     var isPlaying: Binding<Bool> { /* ... */ }
/// }
///
/// struct PlayButton: View {
///     @EnvironmentBinding(\.isPlaying) var isPlaying
///
///     var body: some View {
///         Button(isPlaying ? "Pause" : "Play") {
///             isPlaying.toggle()
///         }
///     }
/// }
/// ```
@propertyWrapper
public struct EnvironmentBinding<BoundValue>: DynamicProperty {
    @Environment private var value: Binding<BoundValue>

    /// The current value of the environment property.
    ///
    /// The wrapped value property provides primary access to the value’s data. However, you don’t access
    /// `wrappedValue` directly. Instead, you read the property variable created with the ``EnvironmentBinding``
    /// property wrapper. In the following code example, the environment binding variable `isPlaying` returns the
    /// value of `wrappedValue`:
    ///
    /// ```swift
    /// struct PlayButton: View {
    ///     @EnvironmentBinding(\.isPlaying) var isPlaying
    ///
    ///     var body: some View {
    ///         Button(isPlaying ? "Pause" : "Play") {
    ///             isPlaying.toggle()
    ///         }
    ///     }
    /// }
    /// ```
    @Binding public var wrappedValue: BoundValue

    /// A projection of the environment binding value that returns a binding.
    ///
    /// Use the projected value to pass a binding value down a view hierarchy. To get the `projectedValue`, prefix
    /// the property variable with $. For example, in the following code example `PlayerView` projects a binding of the
    /// state property `isPlaying` to the `PlayButton` view using `$isPlaying`.
    ///
    /// ```swift
    /// struct PlayerView: View {
    ///     var episode: Episode
    ///     @EnvironmentBinding(\.isPlaying) var isPlaying
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Text(episode.title)
    ///                 .foregroundStyle(isPlaying ? .primary : .secondary)
    ///             PlayButton(isPlaying: $isPlaying)
    ///         }
    ///     }
    /// }
    /// ```
    public var projectedValue: Binding<BoundValue> {
        value
    }

    /// Creates an environment binding property to read the specified key path.
    ///
    /// Don’t call this initializer directly. Instead, declare a property with the ``EnvironmentBinding`` property
    /// wrapper, and provide the key path of the environment binding that the property should reflect:
    ///
    /// ```swift
    /// struct MyView: View {
    ///     @EnvironmentBinding(\.isPlaying) var isPlaying
    ///
    ///     // ...
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: A key path to a specific resulting binding.
    public init(_ keyPath: KeyPath<EnvironmentValues, Binding<BoundValue>>) {
        let environment = Environment(keyPath)
        self._value = environment
        self._wrappedValue = environment.wrappedValue
    }

    public mutating func update() {
        _wrappedValue = value
    }
}
