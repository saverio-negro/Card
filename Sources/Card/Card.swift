//
//  Card.swift
//  MyComponents
//
//  Created by Saverio Negro on 6/20/25.
//

import SwiftUI

/// This is a flexible container that wraps — using @ViewBuilder — any content passed to it,
/// making it useful for previews, forms, lists and dashboards.
public struct Card<Content: View>: View {
    
    // MARK: - Properties
    
    /// The actual view content to wrap inside the card
    let content: Content
    
    // MARK: - Init
    
    /// Create a card instance by passing SwiftUI content and wrapping it in a tuple of views
    /// using ViewBuilder
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        content
            .padding()
        // Layer the specified view behind `content` view
            .background(
                RoundedRectangle(
                    cornerRadius: 12,
                    style: .continuous
                )
                .fill(Color(.white)) // Makes it match light/dark modes
            )
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}
