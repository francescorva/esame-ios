import SwiftUI

struct MyTextField: View {
    var withIcon: String
    @Binding var textValue: String
    var isMandatory: Bool = false
    var isSecret: Bool = false
    var textHint: String

    var body: some View {
        HStack {
            Image(systemName: withIcon)
                .foregroundColor(.gray)

            if isSecret {
                SecureField(textHint, text: $textValue)
            } else {
                TextField(textHint, text: $textValue)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isMandatory && textValue.isEmpty ? .red : .gray, lineWidth: 1)
        )
        .padding(.horizontal, 10)
    }
}
