import SimpleTable
import SwiftUI

struct ColorsTableExample: View {
  struct Color: Identifiable {
    var id: String { name }
    var name: String
    var value: SwiftUI.Color
  }

  var colors: [Color] = [
    .init(name: "red", value: .red),
    .init(name: "green", value: .green),
    .init(name: "blue", value: .blue),
    .init(name: "purple", value: .purple),
    .init(name: "cyan", value: .cyan),
    .init(name: "teal", value: .teal),
    .init(name: "brown", value: .brown),
    .init(name: "indigo", value: .indigo),
    .init(name: "mint", value: .mint),
  ]

  var body: some View {
    SimpleTableLayout(
      columnsCount: 3,
      equalColumnWidths: true,
      equalRowHeights: true
    ) {
      ForEach(colors) { color in
        Text(color.name)
          .font(.system(size: 20 * fontScale(for: color)))
          .padding()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(color.value)
          .padding(1)
      }
    }
  }

  func fontScale(for color: Color) -> CGFloat {
    let lettersCount = CGFloat(color.name.count)
    let minLettersCount = CGFloat(colors.map(\.name.count).min()!)
    let maxLettersCount = CGFloat(colors.map(\.name.count).max()!)
    let minFontScale = CGFloat(0.5)
    return minFontScale + ((lettersCount - minLettersCount) / (maxLettersCount - minLettersCount)) * (1 - minFontScale)
  }
}

struct ColorsTableExample_Previews: PreviewProvider {
  static var previews: some View {
    ColorsTableExample()
  }
}
