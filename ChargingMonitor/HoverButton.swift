// HoverButton.swift

import SwiftUI
import AppKit // Import AppKit for NSHapticFeedbackManager

struct HoverButton: View {
    var action: () -> Void
    var imageName: String

    @State private var isHovered: Bool = false

    var body: some View {
        Button(action: {
            action()
//            triggerHapticFeedback()
        }) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding()
                .background(isHovered ? Color.blue.opacity(0.2) : Color.clear)
                .clipShape(Circle())
        }
        .buttonStyle(BorderlessButtonStyle())
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .accessibilityLabel(accessibilityLabel)
    }

    private var accessibilityLabel: String {
        switch imageName {
        case "arrow.clockwise":
            return "Refresh"
        case "plus":
            return "Add Device"
        default:
            return "Button"
        }
    }

//    private func triggerHapticFeedback() {
//        let generator = NSHapticFeedbackManager.defaultPerformer()
//        generator.perform(NSHapticFeedbackPattern.generic, performanceTime: .now)
//    }
}

struct HoverButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HoverButton(action: {
                print("Refresh tapped")
            }, imageName: "arrow.clockwise")

            HoverButton(action: {
                print("Add Device tapped")
            }, imageName: "plus")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
