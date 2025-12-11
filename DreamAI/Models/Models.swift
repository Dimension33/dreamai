import Foundation

struct Dream: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
    let tags: [String]
    let interpretation: String?
    let mood: String // e.g., "Anxious", "Magical"
}

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
    let username: String
    let timeAgo: String
    let likes: Int
    let comments: Int
    let isTrending: Bool
    let backgroundImageURL: String?
}

struct GuidedSession: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let duration: String // "10 mins"
    let level: String // "Beginner"
    let instructor: String
    let instructorImageURL: String
    let imageURL: String
    let icon: String // SF Symbol name
}

struct TrendingDreamItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageURL: String
    let isTrending: Bool
}

struct DictionaryEntry: Identifiable {
    let id = UUID()
    let symbol: String
    let meaning: String
    let imageURL: String
    let icon: String
}

struct ZodiacSign: Identifiable {
    let id = UUID()
    let name: String
    let dateRange: String
    let description: String
    let element: String // "FIRE SIGN"
    let icon: String
}
