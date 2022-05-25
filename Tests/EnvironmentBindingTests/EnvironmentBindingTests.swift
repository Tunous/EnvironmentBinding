import XCTest
import SwiftUI
@testable import EnvironmentBinding

private var testValue = false

final class EnvironmentBindingTests: XCTestCase {
    func testAccessesValueFromBinding() throws {
        let environmentBinding = EnvironmentBinding(\.isPlaying)

        testValue = false
        XCTAssertFalse(environmentBinding.wrappedValue)

        testValue = true
        XCTAssertTrue(environmentBinding.wrappedValue)
    }

    func testModifiesValue() throws {
        let environmentBinding = EnvironmentBinding(\.isPlaying)

        testValue = false
        environmentBinding.wrappedValue.toggle()
        XCTAssertTrue(testValue)
    }

    func testProjectedValueReturnsBinding() throws {
        let environmentBinding = EnvironmentBinding(\.isPlaying)

        testValue = false
        XCTAssertFalse(environmentBinding.projectedValue.wrappedValue)
        environmentBinding.projectedValue.wrappedValue.toggle()
        XCTAssertTrue(environmentBinding.projectedValue.wrappedValue)
    }
}

private struct IsPlayingKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = Binding { testValue } set: { testValue = $0 }
}

extension EnvironmentValues {
    var isPlaying: Binding<Bool> {
        get { self[IsPlayingKey.self] }
        set { self[IsPlayingKey.self] = newValue }
    }
}
