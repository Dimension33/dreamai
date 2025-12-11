import SwiftUI

struct JournalView: View {
    let weekDays = ["M", "T", "W", "T", "F", "S", "S"]
    let currentDayIndex = 3 // Thursday (index 3) is Today in the mock

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.backgroundDark.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        HStack {
                            Spacer()
                            Text("Dream Journal")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.top, 10)

                        // Hero Streak Section
                        ZStack {
                            Circle()
                                .fill(Color.theme.primary.opacity(0.2))
                                .frame(width: 200, height: 200)
                                .blur(radius: 60)

                            VStack(spacing: 8) {
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color.theme.primary)
                                    .padding(12)
                                    .background(Color.theme.primary.opacity(0.1))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.theme.primary.opacity(0.2), lineWidth: 1))

                                Text("12")
                                    .font(.system(size: 60, weight: .black))
                                    .foregroundColor(.white)

                                Text("Day Streak")
                                    .font(.headline)
                                    .foregroundColor(Color.theme.textSecondary)

                                Text("You're on fire! Keep logging your dreams to unlock the 'Lucid Master' badge.")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.gray)
                                    .frame(maxWidth: 260)
                                    .padding(.top, 4)
                            }
                        }
                        .padding(.vertical, 20)

                        // Weekly Progress
                        VStack(spacing: 12) {
                            HStack {
                                Text("This Week")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Button("View Calendar") { }
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.theme.primary)
                            }

                            HStack(spacing: 0) {
                                ForEach(0..<7) { index in
                                    dayView(index: index)
                                    if index != 6 { Spacer() }
                                }
                            }
                            .padding()
                            .background(Color.theme.cardDark)
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)

                        // Stats Grid
                        HStack(spacing: 12) {
                            statCard(icon: "book", value: "48", label: "Total Logs", color: .theme.primary)
                            statCard(icon: "wand.and.stars", value: "3", label: "Lucid Dreams", color: .purple, highlight: true)
                            statCard(icon: "bed.double", value: "7.5h", label: "Avg Sleep", color: .teal)
                        }
                        .padding(.horizontal)

                        // Achievements
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Achievements")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    achievementCard(icon: "🚀", title: "First Step", subtitle: "Log 1st dream", unlocked: true, color: .theme.primary)
                                    achievementCard(icon: "👁️", title: "Awakened", subtitle: "1st Lucid dream", unlocked: true, color: .purple)
                                    achievementCard(icon: "lock.fill", title: "Month Master", subtitle: "30 day streak", unlocked: false, color: .gray)
                                    achievementCard(icon: "lock.fill", title: "Architect", subtitle: "Control 5 dreams", unlocked: false, color: .gray)
                                }
                                .padding(.horizontal)
                            }
                        }

                        // Smart Reminders
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Smart Reminders")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)

                            VStack(spacing: 1) {
                                reminderRow(icon: "sun.max.fill", title: "Morning Nudge", subtitle: "07:00 AM", color: .orange, isOn: true)
                                reminderRow(icon: "hand.tap.fill", title: "Reality Check", subtitle: "Random • 3x / day", color: .blue, isOn: false)
                            }
                            .background(Color.theme.cardDark)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }

                        Spacer(minLength: 100)
                    }
                }

                // Floating Action Button
                VStack {
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Log Tonight's Dream")
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.theme.primary)
                        .cornerRadius(16)
                        .shadow(color: Color.theme.primary.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }

    func dayView(index: Int) -> some View {
        VStack(spacing: 8) {
            if index < currentDayIndex {
                // Completed
                Circle()
                    .fill(Color.theme.primary)
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "checkmark").font(.caption).bold().foregroundColor(.white))
                Text(weekDays[index])
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            } else if index == currentDayIndex {
                // Today
                Circle()
                    .stroke(Color.theme.primary, lineWidth: 2)
                    .frame(width: 32, height: 32)
                    .overlay(Text(weekDays[index]).font(.caption).bold().foregroundColor(Color.theme.primary))
                Text("Today")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.primary)
            } else {
                // Future
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 32, height: 32)
                    .overlay(Text(weekDays[index]).font(.caption).bold().foregroundColor(.gray))
                Text(weekDays[index])
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
        }
    }

    func statCard(icon: String, value: String, label: String, color: Color, highlight: Bool = false) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(label)
                .font(.caption)
                .foregroundColor(Color.theme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(highlight ? color.opacity(0.1) : Color.theme.cardDark)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(highlight ? color.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }

    func achievementCard(icon: String, title: String, subtitle: String, unlocked: Bool, color: Color) -> some View {
        VStack(spacing: 12) {
            ZStack {
                if unlocked {
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 48, height: 48)
                        .shadow(color: color.opacity(0.4), radius: 8)
                    Text(icon)
                        .font(.title2)
                } else {
                    Circle()
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 48, height: 48)
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                }
            }

            VStack(spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(unlocked ? .white : .gray)
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .frame(width: 140)
        .background(
            LinearGradient(
                colors: [unlocked ? color.opacity(0.1) : Color.theme.cardDark, Color.theme.cardDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(unlocked ? color.opacity(0.3) : Color.white.opacity(0.05), lineWidth: 1)
        )
        .saturation(unlocked ? 1 : 0)
    }

    func reminderRow(icon: String, title: String, subtitle: String, color: Color, isOn: Bool) -> some View {
        HStack {
            Image(systemName: icon)
                .padding(8)
                .background(color.opacity(0.1))
                .foregroundColor(color)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Toggle("", isOn: .constant(isOn))
                .labelsHidden()
                .tint(Color.theme.primary)
        }
        .padding()
        .background(Color.theme.cardDark)
    }
}
