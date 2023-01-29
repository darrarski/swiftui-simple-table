import SwiftUI

/// Wrapper for `SimpleTableLayout` that embeds provided content in a `ScrollView`
public struct SimpleTableView<Content>: View where Content: View {
  /// Content scrolling mode
  public enum ScrollMode: Hashable {
    /// Always scroll, even if provided content fits the view.
    case always
    /// Enable scrolling if provided content does not fit the view.
    case automatic
  }

  struct ScrollInfo: Equatable {
    var contentSize: CGSize
    var scrolledToStart: Bool
  }

  /// Wrapper for `SimpleTableLayout` that embeds provided content in a `ScrollView`
  ///
  /// - Parameters:
  ///   - scrollMode: Scroll view mode. Defaults to `.automatic`.
  ///   - scrollAxes: Scrolling axes. Defaults to `.vertical` & `.horizontal`.
  ///   - showsScrollIndicators: Determines if scroll indicators should be visible. Defaults to `true`.
  ///   - content: Table content. Use `SimpleTableLayout` to arrange views in table.
  public init(
    scrollMode: ScrollMode = .automatic,
    scrollAxes: Axis.Set = [.vertical, .horizontal],
    showsScrollIndicators: Bool = true,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.scrollMode = scrollMode
    self.scrollAxes = scrollAxes
    self.showsScrollIndicators = showsScrollIndicators
    self.content = content
  }

  public var scrollAxes: Axis.Set
  public var scrollMode: ScrollMode
  public var showsScrollIndicators: Bool
  public var content: () -> Content
  let startAnchorId = "simple-table-start-anchor-id"

  public var body: some View {
    switch scrollMode {
    case .automatic:
      ViewThatFits(in: scrollAxes) {
        content()

        scrollView {
          content()
        }
      }

    case .always:
      scrollView {
        content()
      }
    }
  }

  @ViewBuilder
  func scrollView<Content: View>(
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    GeometryReader { scrollGeometry in
      ScrollViewReader { scrollProxy in
        ScrollView(
          scrollAxes,
          showsIndicators: showsScrollIndicators
        ) {
          content()
            .coordinateSpace(name: SimpleTableCoordinateSpaceName.content)
            .frame(
              minWidth: scrollGeometry.size.width,
              minHeight: scrollGeometry.size.height,
              alignment: .topLeading
            )
            .overlay(alignment: .topLeading) {
              Color.clear.frame(width: 10, height: 10)
                .allowsHitTesting(false)
                .id(startAnchorId)
            }
            .background {
              GeometryReader { contentGeometry in
                let scrollFrame = scrollGeometry.frame(in: .global)
                let contentFrame = contentGeometry.frame(in: .global)
                let info = ScrollInfo(
                  contentSize: contentFrame.size,
                  scrolledToStart: contentFrame.minX >= scrollFrame.minX && contentFrame.minY >= scrollFrame.minY
                )

                Color.clear.onChange(of: info) { old, new in
                  if old.contentSize != new.contentSize,
                     old.scrolledToStart == true,
                     new.scrolledToStart == false
                  {
                    DispatchQueue.main.async {
                      scrollProxy.scrollTo(startAnchorId)
                    }
                  }
                }
              }
            }
        }
        .coordinateSpace(name: SimpleTableCoordinateSpaceName.scroll)
        .onAppear {
          scrollProxy.scrollTo(startAnchorId)
        }
      }
    }
  }
}
