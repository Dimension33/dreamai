import SwiftUI

struct SubmitQuoteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var quoteText = ""
    @State private var authorText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.backgroundDark.ignoresSafeArea()

                VStack(spacing: 24) {
                    // Header Text
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Share wisdom")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Contribute to the community collection of Stoic thoughts. Your insight helps others find clarity.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Form Fields
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("The Quote")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)

                            TextEditor(text: $quoteText)
                                .scrollContentBackground(.hidden)
                                .background(Color.theme.surfaceDark) // darker input bg
                                .cornerRadius(12)
                                .frame(height: 180)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .padding(1) // Avoid cut off
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Author / Source")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)

                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                TextField("e.g. Marcus Aurelius", text: $authorText)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.theme.surfaceDark)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }

                    // Guidelines
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color.theme.primary)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Moderation Policy")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("All submissions are reviewed by our community moderators. Please ensure the quote is accurate.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.theme.primary.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.theme.primary.opacity(0.2), lineWidth: 1)
                    )

                    Spacer()

                    // Submit Button
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Text("Submit Contribution")
                            Image(systemName: "paperplane")
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.theme.primary)
                        .cornerRadius(16)
                        .shadow(color: Color.theme.primary.opacity(0.3), radius: 10, y: 5)
                    }
                    .disabled(quoteText.isEmpty || authorText.isEmpty)
                    .opacity(quoteText.isEmpty || authorText.isEmpty ? 0.6 : 1)
                }
                .padding(24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Submit Quote")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
