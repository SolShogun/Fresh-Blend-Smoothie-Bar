# Fresh-Blend-Smoothie-Bar
A polished interactive iOS smoothie ordering app built with SwiftUI.
Features
- Four smoothies with descriptions and prices
- Quantity selection using @State, @Binding, and Stepper
- Protein boost toggle (+$1.50 per selected smoothie)
- Conditional confirmation text when protein is enabled
- Live subtotal and total calculations
- Disabled Place Order button until at least one smoothie is selected
- Order confirmation alert with item count and total; resets order after dismissal
- Green-and-cream design with SF Symbols visual elements
- Extra explored SwiftUI views: Stepper, ScrollView, and Divider (marked in source comments)
Requirements
- macOS with Xcode 15 or later
- iOS 16 or later target
How to run
1. Open Xcode and choose Create New Project > iOS > App.
2. Name the project FreshBlend, select SwiftUI for Interface and Swift for Language.
3. Replace the generated FreshBlendApp.swift and ContentView.swift with the two files in the FreshBlend/ directory here.
4. Choose an iPhone simulator and press Run (Cmd+R).
5. Tap the plus and minus Stepper buttons, optionally enable protein, then tap Place Order.
GitHub submission
1. Create a new GitHub repository named FreshBlendSwiftUI.
2. Commit the complete Xcode project folder (FreshBlend.xcodeproj and the Swift source files), along with this README.
3. Submit the repository URL in Canvas.
Note: This download contains the source files, not an automatically generated .xcodeproj bundle. Create the Xcode project using the instructions above before uploading your final repository.
