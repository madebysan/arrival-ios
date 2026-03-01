import SwiftUI

// Searchable station list, filtered by route
struct StationPickerView: View {
    @State private var searchText = ""

    let route: String
    let onSelect: (Station) -> Void

    private var filteredStations: [Station] {
        StationStore.shared.search(query: searchText, route: route)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Station count
            Text("\(filteredStations.count) stations on the \(route) line")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.vertical, 6)

            // Station list
            List(filteredStations) { station in
                Button {
                    onSelect(station)
                } label: {
                    HStack(spacing: 10) {
                        SubwayBullet(route: route, size: 24)

                        Text(station.name)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .lineLimit(1)

                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
        }
        .searchable(text: $searchText, prompt: "Search stations")
    }
}
