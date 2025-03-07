//
//  PrivacyPolicy.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-03-07.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Privacy Policy")
                    .font(.title)
                    .bold()
                
                Text("Last Updated: March 7, 2025")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("1. No Data Collection")
                    .font(.headline)
                Text(
                    "We do not collect, store, or share any personal data, usage data, or any other form of information from users of **Paths Police**. Your privacy is fully respected, and all app functionality operates without requiring personal information."
                )
                .padding(.bottom, 10)
                
                Text("2. No Third-Party Tracking")
                    .font(.headline)
                Text(
                    "We do not use third-party analytics tools, cookies, or tracking technologies to monitor user activity."
                )
                .padding(.bottom, 10)
                
                Text("3. No Data Sharing")
                    .font(.headline)
                Text(
                    "Since we do not collect any user data, we do not share, sell, or disclose any information to third parties."
                )
                .padding(.bottom, 10)
                
                Text("4. Security")
                    .font(.headline)
                Text(
                    "As our app does not collect or store any data, there are no security risks related to data storage or transmission."
                )
                .padding(.bottom, 10)
                
                Text("5. Changes to This Privacy Policy")
                    .font(.headline)
                Text(
                    "We may update this Privacy Policy from time to time. Any changes will be posted on this page with a revised 'Last Updated' date."
                )
                .padding(.bottom, 10)
                
                Text("6. Contact Us")
                    .font(.headline)
                Text(
                    "If you have any questions or concerns about this Privacy Policy, please contact us at:"
                )
                .padding(.bottom, 10)
                
                HStack {
                    Text("📧 Email: ")
                    Link(
                        "xie.zeyu20@gmail.com",
                        destination: URL(string: "mailto:xie.zeyu20@gmail.com")!
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .scrollIndicators(.hidden)
    }
}
