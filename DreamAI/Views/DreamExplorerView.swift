import SwiftUI

struct DreamExplorerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    let categories = ["All", "Nightmares", "Animals", "Body", "Lucid", "Nature"]

    var body: some View {
        ZStack {
            Color.theme.backgroundDark.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.theme.textSecondary)
                        TextField("What did you dream about?", text: $searchText)
                            .foregroundColor(.white)
                            .onChange(of: searchText) { oldValue, newValue in
                                if oldValue.isEmpty && !newValue.isEmpty {
                                    HapticsManager.shared.playLight()
                                }
                            }
                    }
                    .padding()
                    .background(Color.theme.cardDark) // Using a darker bg instead of white for dark mode consistency
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(cat == "All" ? Color.theme.primary : Color.theme.cardDark)
                                    .foregroundColor(cat == "All" ? .white : .white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.1), lineWidth: cat == "All" ? 0 : 1)
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Trending Headline
                    HStack {
                        Text("Trending this Week")
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
                    .padding(.horizontal)

                    // Trending Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            trendingCard(
                                title: "Flying High",
                                desc: "A symbol of freedom and escaping earthly limitations.",
                                imageColor: .blue,
                                badge: "#1 Trending"
                            )
                            trendingCard(
                                title: "Being Chased",
                                desc: "Avoidance of a difficult situation or emotion.",
                                imageColor: .gray,
                                badge: nil
                            )
                            trendingCard(
                                title: "Teeth Falling Out",
                                desc: "Fear of aging, loss of power, or communication issues.",
                                imageColor: .pink,
                                badge: nil
                            )
                        }
                        .padding(.horizontal)
                    }

                    // Dictionary Headline
                    Text("Dream Dictionary")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    // Dictionary List
                    VStack(spacing: 12) {
                        dictionaryCard(
                            icon: "airplane",
                            title: "Flying",
                            desc: "Represents a desire for freedom or escape from current pressures.",
                            imageColor: .orange
                        )
                        dictionaryCard(
                            icon: "arrow.down",
                            title: "Falling",
                            desc: "Often indicates insecurity, anxiety, or a feeling of losing control.",
                            imageColor: .red
                        )
                         dictionaryCard(
                            icon: "water.waves",
                            title: "Water / Ocean",
                            desc: "Reflects your emotional state; calm water suggests peace, turbulent water anxiety.",
                            imageColor: .blue
                        )
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 80)
                }
                .padding(.top)
            }

            // FAB
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        HapticsManager.shared.playMedium()
                    }) {
                        HStack {
                            Image(systemName: "wand.and.stars")
                            Text("Interpret My Dream")
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(Color.theme.primary)
                        .cornerRadius(30)
                        .shadow(color: Color.theme.primary.opacity(0.4), radius: 10, y: 5)
                    }
                    .padding(24)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    HapticsManager.shared.playLight()
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Common Dreams")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func trendingCard(title: String, desc: String, imageColor: Color, badge: String?) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(imageColor.opacity(0.5))
                    .frame(height: 135)

                if let badge = badge {
                    Text(badge)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.theme.primary.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .padding(8)
                }
            }
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(desc)
                    .font(.caption)
                    .foregroundColor(Color.theme.textSecondary)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .frame(width: 240)
        .background(Color.theme.cardDark)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05)))
    }

    func dictionaryCard(icon: String, title: String, desc: String, imageColor: Color) -> some View {
        NavigationLink(destination: DreamFactorsView()) { // Link to Factors as placeholder
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Image(systemName: icon)
                            .foregroundColor(Color.theme.primary)
                        Text(title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(Color.theme.textSecondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                RoundedRectangle(cornerRadius: 8)
                    .fill(imageColor.opacity(0.3))
                    .frame(width: 64, height: 64)
            }
            .padding(16)
            .background(Color.theme.cardDark)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05)))
        }
    }
}
