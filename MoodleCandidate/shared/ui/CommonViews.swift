import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text(AppStrings.somethingWentWrong)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button(AppStrings.retry, action: retry)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

