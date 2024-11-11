// ThermalStateBadge.swift

import SwiftUI

struct ThermalStateBadge: View {
    var state: String

    var body: some View {
        Text(state.capitalized)
            .font(.caption)
            .padding(5)
            .background(badgeColor(state: state))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .transition(.scale)
    }

    private func badgeColor(state: String) -> Color {
        switch state.lowercased() {
        case "nominal":
            return .green
        case "fair":
            return .yellow
        case "serious":
            return .orange
        case "critical":
            return .red
        default:
            return .gray
        }
    }
}

struct ThermalStateBadge_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThermalStateBadge(state: "nominal")
            ThermalStateBadge(state: "fair")
            ThermalStateBadge(state: "serious")
            ThermalStateBadge(state: "critical")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
