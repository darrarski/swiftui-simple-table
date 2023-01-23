import SwiftUI

struct SimpleTableHeaderViewModifier: ViewModifier {
  var row: Bool
  var column: Bool
  @State var frameInScrollView: CGRect = .zero

  func body(content: Content) -> some View {
    content
      .offset(
        x: column ? max(0, -frameInScrollView.minX) : 0,
        y: row ? max(0, -frameInScrollView.minY) : 0
      )
      .background {
        GeometryReader { geometryProxy in
          let frameInScrollView = geometryProxy
            .frame(in: .named(SimpleTableCoordinateSpaceName.scroll))

          Color.clear
            .onAppear { self.frameInScrollView = frameInScrollView }
            .onChange(of: frameInScrollView) { self.frameInScrollView = $0 }
        }
      }
  }
}

extension View {
  /// Make the view a row & column header when embedded in `SimpleTableView`.
  ///
  /// The view will "stick" to the edge and overlay other, non-header rows & columns when
  /// `SimpleTableView` is scrolled.
  ///
  /// - Returns: Modified view
  public func simpleTableHeader() -> some View {
    modifier(SimpleTableHeaderViewModifier(row: true, column: true))
  }

  /// Make the view a row header when embedded in `SimpleTableView`.
  ///
  /// The view will "stick" to the edge and overlay other, non-header rows when
  /// `SimpleTableView` is scrolled.
  ///
  /// - Returns: Modified view.
  public func simpleTableHeaderRow() -> some View {
    modifier(SimpleTableHeaderViewModifier(row: true, column: false))
  }

  /// Make the view a column header when embedded in `SimpleTableView`.
  ///
  /// The view will "stick" to the edge and overlay other, non-header columns when
  /// `SimpleTableView` is scrolled.
  ///
  /// - Returns: Modified view.
  public func simpleTableHeaderColumn() -> some View {
    modifier(SimpleTableHeaderViewModifier(row: false, column: true))
  }
}
