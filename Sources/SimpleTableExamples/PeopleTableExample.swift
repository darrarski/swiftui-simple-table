import SimpleTable
import SwiftUI

struct PeopleTableExample: View {
  struct Person: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var color: Color
    var birthdate: Date
  }

  var people: [Person] = [
    .init(firstName: "John", lastName: "Doe", color: .blue, birthdate: date(1980, 12, 12)),
    .init(firstName: "Bob", lastName: "Secure", color: .red, birthdate: date(1976, 1, 4)),
    .init(firstName: "Alice", lastName: "Securer", color: .green, birthdate: date(2001, 8, 5)),
    .init(firstName: "Simon", lastName: "Cat", color: .cyan, birthdate: date(1996, 3, 26)),
    .init(firstName: "Lion", lastName: "King", color: .purple, birthdate: date(1989, 10, 26)),
    .init(firstName: "Bob", lastName: "Junior", color: .mint, birthdate: date(2010, 6, 11)),
    .init(firstName: "Simon", lastName: "Senior", color: .brown, birthdate: date(1990, 7, 2)),
  ]

  var body: some View {
    SimpleTableView {
      SimpleTableLayout(columnsCount: 6) {
        columnHeaders()

        ForEach(people) { person in
          row(person)
        }
      }
    }
  }

  @ViewBuilder
  func columnHeaders() -> some View {
    Text("Full name")
      .padding(.trailing)
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .leading
      )
      .font(.caption)
      .padding(8)
      .background(.thinMaterial)
      .overlay(alignment: .top) { VStack { Divider() } }
      .overlay(alignment: .bottom) { VStack { Divider() } }
      .overlay(alignment: .leading) { HStack { Divider() } }
      .overlay(alignment: .trailing) { HStack { Divider() } }
      .simpleTableHeader()
      .zIndex(3)

    Group {
      Text("First name")
        .padding(.trailing)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .leading
        )

      Text("Last name")
        .padding(.trailing)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .leading
        )

      Text("Birthdate")
        .padding(.trailing)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .leading
        )

      Text("Age")
        .padding(.leading)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .trailing
        )

      Text("Color")
        .padding(.horizontal)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .center
        )
    }
    .font(.caption)
    .padding(8)
    .background(.thinMaterial)
    .overlay(alignment: .top) { VStack { Divider() } }
    .overlay(alignment: .bottom) { VStack { Divider() } }
    .overlay(alignment: .trailing) { HStack { Divider() } }
    .simpleTableHeaderRow()
    .zIndex(2)
  }

  @ViewBuilder
  func row(_ person: Person) -> some View {
    Text(PersonNameComponentsFormatter().string(from: PersonNameComponents(
      givenName: person.firstName,
      familyName: person.lastName
    )))
    .padding(.trailing)
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .leading
    )
    .padding(8)
    .background(.thinMaterial)
    .background {
      GeometryReader { geometryProxy in
        person.color.frame(width: geometryProxy.size.width / 5)
      }
    }
    .overlay(alignment: .bottom) { VStack { Divider() } }
    .overlay(alignment: .leading) { HStack { Divider() } }
    .overlay(alignment: .trailing) { HStack { Divider() } }
    .simpleTableHeaderColumn()
    .zIndex(1)

    Group {
      Text(person.firstName)
        .padding(.trailing)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .leading
        )

      Text(person.lastName)
        .padding(.trailing)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .leading
        )

      Text("🎂 \(person.birthdate.formatted(date: .abbreviated, time: .omitted))")
        .padding(.trailing)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .leading
        )

      Text("\(age(for: person.birthdate))")
        .padding(.leading)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .trailing
        )

      person.color
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity
        )
    }
    .padding(8)
    .overlay(alignment: .bottom) { VStack { Divider() } }
    .overlay(alignment: .trailing) { HStack { Divider() } }
  }

  static func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    let calendar = Calendar.current
    let components = DateComponents(year: year, month: month, day: day)
    return calendar.date(from: components)!
  }

  func age(for date: Date) -> Int {
    let calendar = Calendar.current
    return calendar.dateComponents([.year], from: date, to: Date()).year!
  }
}

struct PeopleTableExample_Previews: PreviewProvider {
  static var previews: some View {
    PeopleTableExample()
  }
}
