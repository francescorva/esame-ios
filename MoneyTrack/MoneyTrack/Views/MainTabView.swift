import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            MovimentiView()
                .tabItem { Label("Movimenti", systemImage: "list.bullet.rectangle") }
            GraficiView()
                .tabItem { Label("Grafici", systemImage: "chart.pie.fill") }
        }
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
        .environmentObject(DataManager())
        .environmentObject(UserManager())
}
