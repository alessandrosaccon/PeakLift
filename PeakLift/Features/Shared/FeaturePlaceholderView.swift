//
//  FeaturePlaceholderView.swift
//  PeakLift
//

import SwiftUI

struct FeaturePlaceholderView: View {
    let title: String
    let systemImage: String

    var body: some View {
        ContentUnavailableView(title, systemImage: systemImage)
    }
}
