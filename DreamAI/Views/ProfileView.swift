import SwiftUI

struct ProfileView: View {
    @State private var realityCheck = true
    @State private var lucidReminders = false
    @State private var faceID = true

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.backgroundDark.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        // Profile Header
                        VStack(spacing: 12) {
                            ZStack(alignment: .bottomTrailing) {
                                Circle()
                                    .fill(Color.theme.cardDark)
                                    .frame(width: 128, height: 128)
                                    .overlay(
                                        Circle().stroke(Color.theme.primary, lineWidth: 2)
                                    )
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .padding(30)
                                            .foregroundColor(.gray)
                                    )

                                Circle()
                                    .fill(Color.theme.primary)
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Image(systemName: "pencil")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                                    .overlay(
                                        Circle().stroke(Color.theme.backgroundDark, lineWidth: 4)
                                    )
                            }

                            VStack(spacing: 4) {
                                Text("Luna Stargazer")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                Text("luna.dreamer@example.com")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                Text("DREAMAI PLUS")
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.theme.primary.opacity(0.2))
                            .foregroundColor(Color.theme.primary)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.theme.primary.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .padding(.vertical, 30)

                        // Sections
                        VStack(spacing: 24) {
                            sectionHeader(title: "Account")
                            VStack(spacing: 0) {
                                settingsRow(icon: "person", title: "Edit Profile", subtitle: nil, hasArrow: true)
                                settingsRow(icon: "creditcard", title: "Subscription Management", subtitle: "Manage your Plus plan", hasArrow: true)
                            }

                            sectionHeader(title: "App Preferences")
                            VStack(spacing: 0) {
                                // Accent Color
                                HStack {
                                    iconBox(name: "paintpalette")
                                    Text("Accent Color")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)

                                HStack(spacing: 16) {
                                    Circle().fill(Color.theme.primary).frame(width: 40, height: 40)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    Circle().fill(Color.blue.opacity(0.5)).frame(width: 40, height: 40)
                                    Circle().fill(Color.teal.opacity(0.5)).frame(width: 40, height: 40)
                                    Circle().fill(Color.pink.opacity(0.5)).frame(width: 40, height: 40)
                                    Circle().fill(Color.orange.opacity(0.5)).frame(width: 40, height: 40)
                                    Spacer()
                                }
                                .padding(.leading, 80) // 24 + 40 (icon) + 16 (gap)
                                .padding(.bottom, 16)

                                // Detail Level
                                VStack(spacing: 12) {
                                    HStack {
                                        iconBox(name: "brain.head.profile")
                                        Text("Analysis Detail")
                                            .font(.body)
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Complex")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.theme.primary)
                                    }

                                    // Mock Slider
                                    HStack {
                                        ZStack(alignment: .leading) {
                                            Capsule()
                                                .fill(Color.theme.surfaceDark)
                                                .frame(height: 8)
                                            Capsule()
                                                .fill(Color.theme.primary)
                                                .frame(width: 200, height: 8) // 75%
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 16, height: 16)
                                                .offset(x: 192)
                                        }
                                    }
                                    .padding(.leading, 56)

                                    HStack {
                                        Text("Simple")
                                        Spacer()
                                        Text("Standard")
                                        Spacer()
                                        Text("Complex")
                                    }
                                    .padding(.leading, 56)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                    .textCase(.uppercase)
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                            }

                            sectionHeader(title: "Notifications")
                            VStack(spacing: 0) {
                                toggleRow(icon: "sun.max", title: "Morning Reality Check", subtitle: "Daily 8:00 AM", isOn: $realityCheck)
                                toggleRow(icon: "moon.stars", title: "Lucid Reminders", subtitle: "Tips before bed", isOn: $lucidReminders)
                            }

                            sectionHeader(title: "Privacy & Data")
                            VStack(spacing: 0) {
                                toggleRow(icon: "faceid", title: "FaceID Lock", subtitle: nil, isOn: $faceID)
                                settingsRow(icon: "icloud.and.arrow.down", title: "Export Journal", subtitle: nil, hasArrow: true)
                            }

                            // Logout
                            Button(action: {
                                HapticsManager.shared.playHeavy()
                            }) {
                                HStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Log Out")
                                }
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                                )
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 16)

                            Text("DreamAI v2.0.4 (Build 82)")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .fontDesign(.monospaced)
                                .padding(.top, 10)
                                .padding(.bottom, 100)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.theme.backgroundDark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    func sectionHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.horizontal, 24)
    }

    func iconBox(name: String) -> some View {
        Image(systemName: name)
            .frame(width: 40, height: 40)
            .background(Color.theme.primary.opacity(0.1))
            .foregroundColor(Color.theme.primary)
            .cornerRadius(10)
    }

    func settingsRow(icon: String, title: String, subtitle: String?, hasArrow: Bool) -> some View {
        Button(action: {
            HapticsManager.shared.playLight()
        }) {
            HStack(spacing: 16) {
                iconBox(name: icon)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    if let sub = subtitle {
                        Text(sub)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                if hasArrow {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
    }

    func toggleRow(icon: String, title: String, subtitle: String?, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 16) {
            iconBox(name: icon)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                if let sub = subtitle {
                    Text(sub)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
                .tint(Color.theme.primary)
                .onChange(of: isOn.wrappedValue) { _, _ in
                    HapticsManager.shared.playLight()
                }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
    }
}
