import SwiftUI

struct HomeView: View {
    @State private var dreamEntryText: String = ""
    @State private var showingExplorer = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.backgroundDark.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        headerView

                        // New Dream Entry Section
                        newDreamEntrySection

                        // Guided Journals Banner
                        guidedJournalBanner

                        // Recent Entries
                        recentEntriesSection

                        Spacer(minLength: 80) // Space for TabBar
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showingExplorer) {
                DreamExplorerView()
            }
        }
    }

    private var headerView: some View {
        HStack {
            Button(action: {
                HapticsManager.shared.playLight()
                // Toggle Dark Mode (Mock)
            }) {
                Circle()
                    .fill(Color.theme.primary.opacity(0.1))
                    .frame(width: 48, height: 48)
                    .overlay(Image(systemName: "moon.fill").foregroundColor(Color.theme.primary))
            }

            Spacer()

            VStack(spacing: 2) {
                Text("DreamAI")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Good morning, Alex")
                    .font(.caption)
                    .foregroundColor(Color.theme.textSecondary)
            }

            Spacer()

            // Link to Explorer via Search/Profile or just button
            Button(action: {
                HapticsManager.shared.playLight()
                showingExplorer = true
            }) {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .background(Circle().fill(Color.theme.cardDark))
                    .frame(width: 48, height: 48)
                    .overlay(Image(systemName: "magnifyingglass").foregroundColor(.white))
            }
        }
        .padding(.bottom, 10)
    }

    private var newDreamEntrySection: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("New Dream Entry")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.textSecondary)

                TextEditor(text: $dreamEntryText)
                    .scrollContentBackground(.hidden)
                    .background(Color.theme.surfaceDark)
                    .cornerRadius(12)
                    .frame(height: 160)
                    .onChange(of: dreamEntryText) { oldValue, newValue in
                        if oldValue.isEmpty && !newValue.isEmpty {
                            HapticsManager.shared.playLight()
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .foregroundColor(.white)
                    // Placeholder simulation
                    .overlay(
                        Text("Describe what happened, how you felt, and any symbols you remember...")
                            .foregroundColor(Color.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .opacity(dreamEntryText.isEmpty ? 1 : 0)
                            .allowsHitTesting(false),
                        alignment: .topLeading
                    )
            }

            Button(action: {
                HapticsManager.shared.playMedium()
                // Action to analyze
            }) {
                HStack {
                    Image(systemName: "wand.and.stars")
                    Text("Analyze & Log Dream")
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.theme.primary)
                .cornerRadius(12)
                .shadow(color: Color.theme.primary.opacity(0.3), radius: 10, x: 0, y: 5)
            }

            NavigationLink(destination: CommunityQuotesView()) {
                HStack {
                    Image(systemName: "leaf") // self_improvement replacement
                    Text("Or try a Stoic Reflection")
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.textSecondary)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.theme.textSecondary.opacity(0.3), lineWidth: 2)
                )
            }
        }
    }

    private var guidedJournalBanner: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Guided Journals")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)

            NavigationLink(destination: ReflectionsView()) {
                ZStack(alignment: .leading) {
                    LinearGradient(
                        colors: [Color.theme.primary, Color.theme.primaryDark],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("FEATURED")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(20)
                                .foregroundColor(.white)
                            Spacer()
                        }

                        Text("Unlock Your Mind")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Thoughtful and personal. Never boring. Access curated prompts.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(2)
                            .padding(.bottom, 8)

                        HStack {
                            Text("Start a Session")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.primary)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(20)

                    // Decorative icon background
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "book.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .foregroundColor(.white.opacity(0.1))
                                .rotationEffect(.degrees(15))
                                .offset(x: 30, y: -30)
                        }
                        Spacer()
                    }
                }
                .frame(height: 220)
                .cornerRadius(16)
                .shadow(color: Color.theme.primary.opacity(0.3), radius: 10, x: 0, y: 5)
            }
        }
    }

    private var recentEntriesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Recent Entries")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()

                Button("View All") {
                    HapticsManager.shared.playLight()
                }
                .font(.subheadline)
                .foregroundColor(Color.theme.primary)
            }

            // Sample Entries
            entryCard(
                title: "Chased by a giant clock",
                desc: "I was running through a never-ending library corridor...",
                date: "Oct 24",
                mood: "Anxious",
                moodColor: .orange,
                insight: "This suggests a fear of running out of time."
            )

            entryCard(
                title: "Underwater Breathing",
                desc: "Swimming deep underwater but breathing normally...",
                date: "Oct 22",
                mood: "Magical",
                moodColor: .purple,
                insight: "Symbolizes comfort in exploring your subconscious."
            )
        }
    }

    private func entryCard(title: String, desc: String, date: String, mood: String, moodColor: Color, insight: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                    Text(date)
                        .font(.caption)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                }
                .foregroundColor(Color.theme.textSecondary)

                Spacer()

                Text(mood)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(moodColor.opacity(0.2))
                    .foregroundColor(moodColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(moodColor.opacity(0.3), lineWidth: 1)
                    )
                    .cornerRadius(12)
            }

            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(desc)
                .font(.body)
                .foregroundColor(Color.theme.textSecondary)
                .lineLimit(2)

            // Insight Box
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(Color.theme.primary)

                Text(insight)
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .padding(12)
            .background(Color.theme.backgroundDark.opacity(0.5))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
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
