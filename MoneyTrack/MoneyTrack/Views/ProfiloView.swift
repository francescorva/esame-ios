import SwiftUI

struct ProfiloView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                if let u = userManager.utenteLoggato {
                    Text(u.username)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Button {
                    userManager.logout()
                    dismiss()
                } label: {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profilo")
        }
    }
}

#Preview {
    ProfiloView()
        .environmentObject(UserManager())
}
