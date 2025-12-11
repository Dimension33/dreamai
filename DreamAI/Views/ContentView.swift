import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selection = 0

    init() {
        // Customize TabBar appearance if needed
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.theme.backgroundDark).withAlphaComponent(0.95)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.textSecondary)
    }

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: selection == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)

            JournalView()
                .tabItem {
                    Image(systemName: selection == 1 ? "book.fill" : "book")
                    Text("Journal")
                }
                .tag(1)

            ReflectionsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill") // analytics/insights
                    Text("Reflections")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(3)
        }
        .accentColor(Color.theme.primary)
        .preferredColorScheme(.dark) // Default to dark as per the design focus
    }
}
