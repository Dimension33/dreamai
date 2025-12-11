import SwiftUI
import UIKit

struct ShareSheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Background blur/dim
            Color.black.opacity(0.6).ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }

            VStack {
                Spacer()

                VStack(spacing: 0) {
                    // Drag Handle
                    Capsule()
                        .fill(Color.gray.opacity(0.6))
                        .frame(width: 40, height: 6)
                        .padding(.vertical, 12)

                    Text("Share this Insight")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    // Preview Card
                    HStack(spacing: 12) {
                        Rectangle() // Placeholder for image
                            .fill(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 64, height: 64)
                            .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Stoic Wisdom")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("\"The unexamined life is not worth living...\"")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        Spacer()
                    }
                    .padding(12)
                    .background(Color.theme.cardDark)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)

                    // Main Grid
                    VStack(spacing: 24) {
                        // Big Buttons
                        HStack(spacing: 12) {
                            actionButton(icon: "link", label: "Copy Link")
                            actionButton(icon: "arrow.down.to.line", label: "Save Image")
                        }
                        .padding(.horizontal, 20)

                        // Social Row
                        HStack(spacing: 10) { // Should be grid actually
                            socialButton(icon: "camera", label: "Stories")
                            socialButton(icon: "square.and.pencil", label: "Post")
                            socialButton(icon: "bubble.left", label: "Send")
                            socialButton(icon: "list.bullet", label: "Feed")
                            socialButton(icon: "ellipsis", label: "More")
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)

                    // Cancel
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.theme.cardDark)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.1)))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
                .background(Color(hex: "1e1625"))
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
    }

    func actionButton(icon: String, label: String) -> some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.theme.cardDark)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05)))
        }
    }

    func socialButton(icon: String, label: String) -> some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.theme.cardDark)
                .frame(width: 56, height: 56)
                .overlay(Image(systemName: icon).font(.title3).foregroundColor(.white))
                .overlay(Circle().stroke(Color.white.opacity(0.05)))

            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
