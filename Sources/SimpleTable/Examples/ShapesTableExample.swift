#if DEBUG
import SwiftUI

struct _ShapesTableExample: View {
  var body: some View {
    SimpleTableLayout(
      columnsCount: 3,
      cellAspectRatio: 3/4
    ) {
      Group {
        Rectangle().frame(width: 40, height: 30)
        Rectangle().frame(width: 60, height: 20)
        Rectangle().frame(width: 70, height: 10)
        Rectangle().frame(width: 10, height: 90)
        Rectangle().frame(width: 20, height: 60)
        Rectangle().frame(width: 30, height: 40)
      }
      .foregroundColor(.accentColor)
      .padding(1)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .border(.red)
      .padding(1)
    }
  }
}

struct _ShapesTableExample_Previews: PreviewProvider {
  static var previews: some View {
    _ShapesTableExample()
  }
}
#endif
