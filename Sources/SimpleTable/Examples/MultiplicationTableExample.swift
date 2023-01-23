#if DEBUG
import SwiftUI

struct _MultiplicationTableExample: View {
  var body: some View {
    SimpleTableView {
      SimpleTableLayout(
        columnsCount: 11,
        equalColumnWidths: true,
        equalRowHeights: true
      ) {
        header()
        ForEach(1..<11) { column in
          header(column: column)
        }
        ForEach(1..<11) { row in
          header(row: row)
          ForEach(1..<11) { column in
            cell(row: row, column: column)
          }
        }
      }
    }
  }

  func header() -> some View {
    Image(systemName: "multiply")
      .font(.caption.bold())
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.thinMaterial)
      .overlay(alignment: .top) { VStack { Divider() } }
      .overlay(alignment: .bottom) { VStack { Divider() } }
      .overlay(alignment: .leading) { HStack { Divider() } }
      .overlay(alignment: .trailing) { HStack { Divider() } }
      .simpleTableHeader()
      .zIndex(3)
  }

  func header(column: Int) -> some View {
    VStack {
      Text("\(column)")
      Image(systemName: "arrow.down")
    }
    .font(.caption.bold())
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.thinMaterial)
    .overlay(alignment: .top) { VStack { Divider() } }
    .overlay(alignment: .bottom) { VStack { Divider() } }
    .overlay(alignment: .trailing) { HStack { Divider() } }
    .simpleTableHeaderRow()
    .zIndex(2)
  }

  func header(row: Int) -> some View {
    HStack {
      Text("\(row)")
      Image(systemName: "arrow.right")
    }
    .font(.caption.bold())
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.thinMaterial)
    .overlay(alignment: .bottom) { VStack { Divider() } }
    .overlay(alignment: .leading) { HStack { Divider() } }
    .overlay(alignment: .trailing) { HStack { Divider() } }
    .simpleTableHeaderColumn()
    .zIndex(1)
  }

  func cell(row: Int, column: Int) -> some View {
    Text("\(row * column)")
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(alignment: .bottom) { VStack { Divider() } }
      .overlay(alignment: .trailing) { HStack { Divider() } }
  }
}

struct _MultiplicationTableExample_Previews: PreviewProvider {
  static var previews: some View {
    _MultiplicationTableExample()
  }
}
#endif
