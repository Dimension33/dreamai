import SwiftUI

struct CommunityQuotesView: View {
    @State private var showingSubmitSheet = false
    @State private var showingShareSheet = false

    var body: some View {
        ZStack {
            Color.theme.backgroundDark.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header (Custom to match design)
                HStack {
                    Spacer()
                    // Filters
                    HStack(spacing: 24) {
                        Button("Trending") {
                            HapticsManager.shared.playSelection()
                        }
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primary)
                            .overlay(Rectangle().frame(height: 2).foregroundColor(Color.theme.primary).offset(y: 12), alignment: .bottom)
                        Button("Newest") {
                            HapticsManager.shared.playSelection()
                        }
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Button("Top Rated") {
                            HapticsManager.shared.playSelection()
                        }
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.vertical, 12)
                .background(Color.theme.backgroundDark.opacity(0.95))

                ScrollView {
                    LazyVStack(spacing: 20) {
                        // Card 1 (Image Background)
                        quoteCardImage(
                            text: "The happiness of your life depends upon the quality of your thoughts.",
                            author: "Marcus Aurelius",
                            username: "@Dreamer123",
                            likes: "1.2k",
                            comments: "42",
                            imageColor: .purple
                        )

                        // Card 2 (Text only)
                        quoteCardText(
                            text: "We suffer more often in imagination than in reality.",
                            author: "Seneca",
                            username: "@StoicSage",
                            timeAgo: "2h ago",
                            votes: 892
                        )

                        // Card 3 (Image Background)
                        quoteCardImage(
                            text: "Wealth consists not in having great possessions, but in having few wants.",
                            author: "Epictetus",
                            username: "@MindfulWalker",
                            likes: "Trending now",
                            comments: "",
                            imageColor: .green,
                            isVote: true
                        )

                         // Card 4 (Text only)
                        quoteCardText(
                            text: "Man conquers the world by conquering himself.",
                            author: "Zeno of Citium",
                            username: "@ZenoFan",
                            timeAgo: "5h ago",
                            votes: 156 // Simplified for this view
                        )

                        Spacer(minLength: 80)
                    }
                    .padding()
                }
            }

            // FAB
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        HapticsManager.shared.playMedium()
                        showingSubmitSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.theme.primary)
                            .clipShape(Circle())
                            .shadow(color: Color.theme.primary.opacity(0.4), radius: 10, y: 5)
                    }
                    .padding(24)
                }
            }
        }
        .navigationTitle("Community Wisdom")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("My Quotes") {}
            }
        }
        .sheet(isPresented: $showingSubmitSheet) {
            SubmitQuoteView()
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheetView()
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
        }
    }

    func quoteCardImage(text: String, author: String, username: String, likes: String, comments: String, imageColor: Color, isVote: Bool = false) -> some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(
                    LinearGradient(colors: [imageColor.opacity(0.6), Color.black], startPoint: .top, endPoint: .bottom)
                )

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Circle()
                        .fill(imageColor.opacity(0.8))
                        .frame(width: 24, height: 24)
                        .overlay(Text(String(username.prefix(2))).font(.caption2).bold().foregroundColor(.white))
                    Text(username)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.9))
                }

                Text("\"\(text)\"")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(4)

                Text("— \(author)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(imageColor.opacity(0.8) == .black ? .white : imageColor.opacity(1.0).lighter()) // Adjust for readability

                Divider().background(Color.white.opacity(0.2))

                HStack {
                    if isVote {
                        HStack(spacing: 4) {
                            Image(systemName: "bolt.fill")
                            Text(likes)
                        }
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(imageColor.lighter())

                        Spacer()

                        Button("Vote") {
                            HapticsManager.shared.playLight()
                        }
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(imageColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)

                         Button(action: {
                            HapticsManager.shared.playLight()
                            showingShareSheet = true
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white.opacity(0.8))
                        }
                    } else {
                        HStack(spacing: 16) {
                            HStack(spacing: 4) {
                                Image(systemName: "heart")
                                Text(likes)
                            }
                            HStack(spacing: 4) {
                                Image(systemName: "bubble.right")
                                Text(comments)
                            }
                        }
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.9))

                        Spacer()

                        Button(action: {
                            HapticsManager.shared.playLight()
                            showingShareSheet = true
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                }
            }
            .padding(20)
        }
        .frame(height: 300)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
    }

    func quoteCardText(text: String, author: String, username: String, timeAgo: String, votes: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 32, height: 32)
                        .overlay(Text(String(username.prefix(2))).font(.caption).bold().foregroundColor(.white))
                    VStack(alignment: .leading) {
                        Text(username)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(timeAgo)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }

            Text("\"\(text)\"")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.9))

            Text("— \(author)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.primary)

            HStack {
                HStack(spacing: 0) {
                    Image(systemName: "arrow.up")
                        .padding(8)
                        .background(Color.white)
                        .foregroundColor(Color.theme.primary)
                        .clipShape(Circle())

                    Text("\(votes)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 40)

                    Image(systemName: "arrow.down")
                        .padding(8)
                        .foregroundColor(.gray)
                }
                .background(Color.black.opacity(0.2))
                .cornerRadius(20)
                .overlay(Capsule().stroke(Color.white.opacity(0.1)))

                Spacer()

                HStack(spacing: 12) {
                    Image(systemName: "bookmark")
                    Button(action: {
                        HapticsManager.shared.playLight()
                        showingShareSheet = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.gray)
                    }
                }
                .foregroundColor(.gray)
            }
        }
        .padding(20)
        .background(Color.theme.cardDark)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.05)))
    }
}

// Helper to make colors lighter for text on dark bg
extension Color {
    func lighter(by amount: CGFloat = 0.3) -> Color {
        return Color.white // Simplified
    }
}
