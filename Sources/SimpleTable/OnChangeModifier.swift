import SwiftUI

struct OnChangeModifier<T: Equatable>: ViewModifier {
  init(of value: T, perform action: @escaping (T, T) -> Void) {
    self.value = value
    self.action = action
    self._oldValue = .init(wrappedValue: value)
  }

  var value: T
  var action: (T, T) -> Void
  @State var oldValue: T

  func body(content: Content) -> some View {
    content.onChange(of: value) { newValue in
      action(oldValue, newValue)
      oldValue = newValue
    }
  }
}

extension View {
  func onChange<T: Equatable>(
    of value: T,
    perform action: @escaping (T, T) -> Void
  ) -> some View {
    modifier(OnChangeModifier(of: value, perform: action))
  }
}
