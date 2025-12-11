import SwiftUI

struct ReflectionsView: View {
    @State private var searchText = ""
    let categories = ["All", "Dream Work", "Anxiety", "Sleep", "Self-Love"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.backgroundDark.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Search & Filter
                        VStack(spacing: 16) {
                            HStack {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                    TextField("Search topics, feelings...", text: $searchText)
                                        .foregroundColor(.white)
                                }
                                .padding(12)
                                .background(Color.theme.cardDark)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )

                                Button(action: {}) {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.white)
                                        .padding(12)
                                        .background(Color.theme.cardDark)
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                        )
                                }
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(categories, id: \.self) { cat in
                                        Text(cat)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 8)
                                            .background(cat == "All" ? Color.theme.primary : Color.theme.cardDark)
                                            .foregroundColor(cat == "All" ? .white : .gray)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.white.opacity(0.1), lineWidth: cat == "All" ? 0 : 1)
                                            )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)

                        // List Content
                        LazyVStack(spacing: 16) {
                            reflectionCard(
                                title: "Lucid Dreaming Basics",
                                description: "Learn to recognize you're dreaming and gain control over the narrative.",
                                duration: "10 mins",
                                level: "Beginner",
                                author: "Dr. Sarah Cole",
                                imageColor: .purple
                            )

                            reflectionCard(
                                title: "Morning Intentions",
                                description: "Set a purposeful tone for the day ahead with brief, focused prompts.",
                                duration: "3 mins",
                                level: "Daily",
                                author: "Marcus Chen",
                                imageColor: .orange
                            )

                            reflectionCard(
                                title: "Shadow Work",
                                description: "Explore the hidden parts of yourself safely with therapist-guided questions.",
                                duration: "Deep Dive",
                                level: "Verified",
                                author: "Dr. Elena Rostova",
                                imageColor: .black
                            )

                            reflectionCard(
                                title: "Nightmare Recovery",
                                description: "Gentle techniques to process difficult dreams and return to rest.",
                                duration: "Healing",
                                level: "Coping",
                                author: "Maya Paulson",
                                imageColor: .blue
                            )
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 80)
                    }
                }
            }
            .navigationTitle("Guided Reflections")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.theme.backgroundDark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    func reflectionCard(title: String, description: String, duration: String, level: String, author: String, imageColor: Color) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(imageColor.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "waveform.path.ecg") // Placeholder
                            .foregroundColor(.white.opacity(0.5))
                    )

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                    }

                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.caption2)
                            Text(duration)
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.theme.primary.opacity(0.1))
                        .foregroundColor(Color.theme.primary)
                        .cornerRadius(4)

                        Text("• \(level)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Divider().background(Color.white.opacity(0.1))

            HStack {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 24, height: 24)
                    Text(author)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button("Start") {}
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.theme.primary.opacity(0.1))
                    .foregroundColor(Color.theme.primary)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.theme.cardDark)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}
