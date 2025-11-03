import SwiftUI

@main
struct MoneyTrackApp: App {
    @StateObject private var dataManager = DataManager()
    @StateObject private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            if let _ = userManager.utenteLoggato {
                MainTabView()
                    .environmentObject(dataManager)
                    .environmentObject(userManager)
            } else {
                LoginView()
                    .environmentObject(userManager)
            }
        }
    }
}
