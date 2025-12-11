import SwiftUI

struct DreamFactorsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.theme.backgroundDark.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Hero Section
                    ZStack(alignment: .bottomLeading) {
                        Rectangle()
                            .fill(Color.purple.opacity(0.4))
                            .frame(height: 224)

                        LinearGradient(colors: [.clear, Color.theme.backgroundDark], startPoint: .top, endPoint: .bottom)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Insight")
                                .font(.caption)
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(Color.theme.primary)
                                .cornerRadius(20)
                                .overlay(Capsule().stroke(Color.white.opacity(0.1)))

                            Text("What shapes your visions?")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("Explore the esoteric and scientific pillars of dream analysis.")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                        .padding(20)
                    }

                    // Tabs
                    HStack(spacing: 0) {
                        tabButton(icon: "sparkles", text: "Cosmic", isActive: true)
                        tabButton(icon: "123.rectangle", text: "Numbers", isActive: false)
                        tabButton(icon: "brain.head.profile", text: "Mind", isActive: false)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.theme.backgroundDark)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5)

                    // Content Area
                    VStack(spacing: 20) {
                        HStack {
                            Text("Zodiac Influences")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {}) {
                                HStack(spacing: 4) {
                                    Text("View All")
                                    Image(systemName: "arrow.right")
                                }
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.primary)
                            }
                        }

                        // Featured Zodiac Card
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.theme.backgroundDark.opacity(0.7))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.theme.primary.opacity(0.2), lineWidth: 1)
                                )

                            HStack(alignment: .top, spacing: 16) {
                                Circle()
                                    .fill(LinearGradient(colors: [Color.theme.primary, Color.purple.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 56, height: 56)
                                    .overlay(Image(systemName: "flame.fill").foregroundColor(.white))

                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Aries")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Text("Mar 21 - Apr 19")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.theme.primary)
                                                .textCase(.uppercase)
                                        }
                                        Spacer()
                                        Text("FIRE SIGN")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.theme.primary.opacity(0.1))
                                            .foregroundColor(Color.theme.primary)
                                            .cornerRadius(20)
                                            .overlay(Capsule().stroke(Color.theme.primary.opacity(0.2)))
                                    }

                                    Text("Action-oriented dreams, often involving conflict, sports, or taking charge. You may process anger or passion vividly during REM sleep.")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(4)
                                }
                            }
                            .padding(20)
                        }

                        // Secondary Cards
                        zodiacRow(icon: "drop.fill", name: "Pisces", date: "FEB 19 - MAR 20", desc: "Highly spiritual and vivid lucidity.")
                        zodiacRow(icon: "wind", name: "Libra", date: "SEP 23 - OCT 22", desc: "Dreams focused on relationships and balance.")

                        Divider().background(Color.white.opacity(0.1)).padding(.vertical, 10)

                        // Numerology Teaser
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "123.rectangle")
                                    .foregroundColor(Color.theme.primary)
                                Text("Numerology Snapshot")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    numerologyCard(num: "7", label: "Life Path", desc: "Dreams of discovery & deep questions.")
                                    numerologyCard(num: "11:11", label: "Synchronicity", desc: "Signs of spiritual awakening.")
                                }
                            }
                        }
                        .opacity(0.8)
                    }
                    .padding(20)

                    Spacer(minLength: 80)
                }
            }

            // FAB
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "wand.and.stars")
                            Text("Analyze Dream")
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
        .navigationBarHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                 Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Dream Influences")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func tabButton(icon: String, text: String, isActive: Bool) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
            Text(text)
                .font(.caption)
                .fontWeight(.bold)
                .textCase(.uppercase)

            Rectangle()
                .fill(isActive ? Color.theme.primary : Color.clear)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(isActive ? Color.theme.primary : Color.gray)
        .frame(maxWidth: .infinity)
    }

    func zodiacRow(icon: String, name: String, date: String, desc: String) -> some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color.white.opacity(0.05))
                .frame(width: 48, height: 48)
                .overlay(Image(systemName: icon).foregroundColor(.gray))

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(name)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Text(date)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                Text(desc)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.theme.surfaceDark)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05)))
    }

    func numerologyCard(num: String, label: String, desc: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(num)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.primary)
            Text(label)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(desc)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 140)
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05)))
    }
}
