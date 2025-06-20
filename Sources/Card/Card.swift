//
//  Card.swift
//  MyComponents
//
//  Created by Saverio Negro on 6/20/25.
//

/// A card is a container for UI content that:

/// - Groups related UI elements together (like a section of a form, or a news article)

/// - Has a background, rounded corners, and shadow.

/// - May be reused in many contexts — lists, detail views, etc.

import SwiftUI

/// A reusable Card container with rounded corners, shadow, and padding.
///
/// This is a flexible container that wraps (@ViewBuilder) any content passed to it,
/// making it useful for previews, forms, lists and dashboards.
public struct Card<Content: View>: View {
    
    // MARK: - Properties
    
    /// The actual view content to wrap inside the card
    let content: Content
    
    // MARK: - Init
    
    /// Create a card instance by passing SwiftUI content and wrapping it in a tuple of views
    /// using ViewBuilder
    public init(@ViewBuilder content: @escaping () -> Content) {
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
