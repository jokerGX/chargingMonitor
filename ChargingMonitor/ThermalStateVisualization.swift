// ThermalStateVisualization.swift

import SwiftUI

struct ThermalStateVisualization: View {
    var state: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: thermalStateIcon(state: state))
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(thermalStateColor(state: state))
                .scaleEffect(animateIcon ? 1.0 : 0.8)
                .animation(.easeInOut(duration: 0.5), value: animateIcon)
                .onAppear {
                    withAnimation {
                        animateIcon = true
                    }
                }

            Text("Thermal State: \(state.capitalized)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(thermalStateColor(state: state))
                .transition(.opacity)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(thermalStateBackground(state: state))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .animation(.easeInOut, value: state)
    }

    @State private var animateIcon = false

    private func thermalStateIcon(state: String) -> String {
        switch state.lowercased() {
        case "nominal":
            return "thermometer"
        case "fair":
            return "thermometer.sun.fill"
        case "serious":
            return "thermometer.medium"
        case "critical":
            return "thermometer.snowflake"
        default:
            return "questionmark"
        }
    }

    private func thermalStateColor(state: String) -> Color {
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

    private func thermalStateBackground(state: String) -> Color {
        switch state.lowercased() {
        case "nominal":
            return Color.green.opacity(0.2)
        case "fair":
            return Color.yellow.opacity(0.2)
        case "serious":
            return Color.orange.opacity(0.2)
        case "critical":
            return Color.red.opacity(0.2)
        default:
            return Color.gray.opacity(0.2)
        }
    }
}

struct ThermalStateVisualization_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThermalStateVisualization(state: "nominal")
            ThermalStateVisualization(state: "fair")
            ThermalStateVisualization(state: "serious")
            ThermalStateVisualization(state: "critical")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
