import SwiftUI

struct Smoothie: Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let symbol: String
}

struct ContentView: View {
    private let smoothies = [
        Smoothie(id: 0, name: "Strawberry Glow", description: "Strawberry • Banana", price: 6.50, symbol: "strawberry"),
        Smoothie(id: 1, name: "Tropical Sunrise", description: "Mango • Pineapple", price: 7.25, symbol: "sun.max.fill"),
        Smoothie(id: 2, name: "Green Energy", description: "Spinach • Kiwi • Apple", price: 7.75, symbol: "leaf.fill"),
        Smoothie(id: 3, name: "Berry Boost", description: "Blueberry • Raspberry", price: 7.00, symbol: "heart.fill")
    ]
    @State private var quantities = [0, 0, 0, 0]
    @State private var addProtein = false
    @State private var showConfirmation = false

    private var itemCount: Int { quantities.reduce(0, +) }
    private var subtotal: Double {
        smoothies.reduce(0) { $0 + $1.price * Double(quantities[$1.id]) }
    }
    private var total: Double { subtotal + (addProtein ? Double(itemCount) * 1.50 : 0) }

    var body: some View {
        NavigationStack {
            // NEW UI FEATURE: ScrollView keeps the menu usable on smaller iPhones.
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    header
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Our Smoothies").font(.title2.bold()).foregroundStyle(.primary)
                        ForEach(smoothies) { smoothie in
                            SmoothieRow(smoothie: smoothie, quantity: $quantities[smoothie.id])
                        }
                    }
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Make it yours").font(.title2.bold())
                        Toggle(isOn: $addProtein) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Add protein boost").font(.headline)
                                Text("+$1.50 per smoothie").font(.subheadline).foregroundStyle(.secondary)
                            }
                        }.tint(Color(red: 0.16, green: 0.48, blue: 0.32))
                        // Conditional UI: this message only appears when protein is selected.
                        if addProtein {
                            Label("Protein boost added to each smoothie", systemImage: "checkmark.circle.fill")
                                .font(.caption).foregroundStyle(Color(red: 0.12, green: 0.42, blue: 0.26))
                        }
                    }
                    .padding(18)
                    .background(.white, in: RoundedRectangle(cornerRadius: 18))
                    orderSummary
                }
                .padding(20)
            }
            .background(Color(red: 0.96, green: 0.97, blue: 0.94))
            .navigationBarHidden(true)
            .alert("Order Confirmed!", isPresented: $showConfirmation) {
                Button("Done") {
                    quantities = [0, 0, 0, 0]
                    addProtein = false
                }
            } message: {
                Text("Thank you for ordering \(itemCount) smoothie(s)! Your total is \(total.formatted(.currency(code: "USD"))).")
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "leaf.circle.fill")
                    .font(.system(size: 46)).foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 3) {
                    Text("FRESH BLEND").font(.title.bold()).tracking(1.2)
                    Text("SMOOTHIE BAR").font(.caption.weight(.semibold)).tracking(3)
                }.foregroundStyle(.white)
            }
            Text("Good vibes. Fresh ingredients.")
                .font(.title3.weight(.medium)).foregroundStyle(.white.opacity(0.95))
            Text("Build your perfect smoothie order below.")
                .font(.subheadline).foregroundStyle(.white.opacity(0.85))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(red: 0.12, green: 0.39, blue: 0.27), in: RoundedRectangle(cornerRadius: 24))
    }

    private var orderSummary: some View {
        VStack(spacing: 13) {
            HStack {
                Text("Order Summary").font(.title2.bold())
                Spacer()
                Text("\(itemCount) item(s)").foregroundStyle(.secondary)
            }
            Divider()
            summaryLine("Smoothies", subtotal)
            if addProtein && itemCount > 0 { summaryLine("Protein boosts", Double(itemCount) * 1.50) }
            Divider()
            HStack {
                Text("Total").font(.title3.bold())
                Spacer()
                Text(total, format: .currency(code: "USD"))
                    .font(.title2.bold()).foregroundStyle(Color(red: 0.12, green: 0.39, blue: 0.27))
            }
            Button { showConfirmation = true } label: {
                HStack {
                    Image(systemName: "bag.fill")
                    Text("Place Order").fontWeight(.bold)
                }
                .frame(maxWidth: .infinity).padding(16)
                .foregroundStyle(.white)
                .background(itemCount > 0 ? Color(red: 0.12, green: 0.39, blue: 0.27) : .gray,
                            in: RoundedRectangle(cornerRadius: 14))
            }
            .disabled(itemCount == 0)
            if itemCount == 0 {
                Text("Choose at least one smoothie to place an order.")
                    .font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding(18)
        .background(.white, in: RoundedRectangle(cornerRadius: 18))
    }

    private func summaryLine(_ label: String, _ amount: Double) -> some View {
        HStack {
            Text(label).foregroundStyle(.secondary)
            Spacer()
            Text(amount, format: .currency(code: "USD"))
        }
    }
}

struct SmoothieRow: View {
    let smoothie: Smoothie
    @Binding var quantity: Int

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: smoothie.symbol == "strawberry" ? "drop.fill" : smoothie.symbol)
                .font(.system(size: 25))
                .foregroundStyle(Color(red: 0.14, green: 0.48, blue: 0.32))
                .frame(width: 56, height: 56)
                .background(Color(red: 0.89, green: 0.95, blue: 0.87), in: RoundedRectangle(cornerRadius: 14))
            VStack(alignment: .leading, spacing: 4) {
                Text(smoothie.name).font(.headline)
                Text(smoothie.description).font(.caption).foregroundStyle(.secondary)
                Text(smoothie.price, format: .currency(code: "USD"))
                    .font(.subheadline.bold()).foregroundStyle(Color(red: 0.12, green: 0.39, blue: 0.27))
            }
            Spacer(minLength: 4)
            // NEW UI FEATURE: Stepper manages quantity and updates the total through @Binding.
            Stepper(value: $quantity, in: 0...10) {
                Text("\(quantity)").font(.headline.monospacedDigit())
            }
            .labelsHidden()
            Text("\(quantity)").font(.headline.monospacedDigit()).frame(minWidth: 16)
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview { ContentView() }
