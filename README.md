# 02 - Reusable Card View Component

## Introduction

<img src="./Card.png" width="25%" height="25%"/>

The second component of my series is a reusable `Card` view. It's still very simple, but its inner workings lay down the foundation on which frameworks like `SwiftUICharts`, or `SwiftUI Essentials` are built.

You may ask yourself why a `Card` view?

That's my personal opinion, but it's one of those views that many developers find themselves using the most, since it immediately gives out the idea of a _container_. What's important to take away is the idea of a container, and you might have called your component something else.

A `Card` view is nothing but a container for UI content that:

- Groups UI elements together (e.g., a section of a form, a news article).

- Has a background, rounded corners, and a shadow.

- May be reused in many contexts (e.g., lists, detail views, dashboard layouts).

## Component Description

Let me walk you through the code for the `Card` view component implementation.

First off, we have the line defining the `Card` struct itself.

```swift
public struct Card<Content: View>: View {
```

Well, this is a **generic** struct — its code works with any type, as long as that type conforms to the `View` protocol. `Content` in `<Content: View>` is just a type parameter name, which also specifies the constraints — conformance to the `View` protocol. Also, `Card` itself conforms to the `View` protocol, which makes it a type of `View` as well. That also means that it can be rendered in SwiftUI, upon invocation of the `body` property, much like we can render a native `Text` or `VStack` view — they also are of type `View`.

Next up,

```swift
let content: Content
```

`content` in the line of code `let content: Content` represents the actual content to be passed in. 

Most likely, The content that `Card` may be passed in by the user might consist of multiple views, which are eventually being wrapped into a `TupleView` via the `@ViewBuilder` property wrapper. That way, we have control over `content`, so that we can later lay it out by returning it from within the `body` computed property of the `Card` struct itself. That will have the effect of the `Card` view rendering all the UI contents that the user passed to `Card`, via its constructor.

Speaking of the `Card` constructor/initializer, let's have a look at its signature:

```swift
public init(@ViewBuilder content: () -> Content) {
```

`Card` uses a `public` initializer. I used the `public` access modifier because we want the user tapping into our framework to be able to instantiate our `Card` struct from outside of our module, and from within their app module. For the same reason, I used `public` when defining the `Card` struct itself.

Also, notice how I used the `@ViewBuilder` property wrapper, which allows us to wrap multiple child views into a `TupleView` object, in the order they were defined by the user. The problem that it solves relates to the fact that Swift doesn't allow us to return multiple times from a function, since returning from a function exits the function itself. More so, we can't return multiple objects from a function, unless we collect them into a data structure (e.g., array, tuple, dictionary, etc.). That's actually what SwiftUI's `@ViewBuilder` tries to do: it wraps the multiple views being defined within a function's body into a `TupleView`, which is a type conforming to the `View` protocol that tries to bundle all the views using Swift tuples under the hood. Ultimately, this bundled view — which gets returned by the function passed in by the user and called from within the `Card` initializer — is assigned to the `content` property.

```swift
public init(@ViewBuilder content: () -> Content) {
  self.content = content()
}
```

Finally, we are rendering the `content` property from within the `body` property of our `Card` view, which will display it on the screen.

Also, I customized its layout by applying modifiers on it: the code pads it using `padding()`, layers a `RoundedRectangle` shape behind our content view as its background, and adds a slight and elegant shadow to give it a nice and Apple-like hovering effect. 

```swift
public var body: some View {
        content
            .padding()
        // Layer the specified view behind `content` view
            .background(
                RoundedRectangle(
                    cornerRadius: 12,
                    style: .continuous
                )
                .fill(Color.white) // Makes it match light/dark modes
            )
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
}
```


