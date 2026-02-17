import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            let sunDiameter = max(width, height) * 0.36
            let sunX = width * 0.20
            let sunY = -height * 0.26

            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: Color(red: 0.96, green: 0.72, blue: 0.80), location: 0.00),
                        .init(color: Color(red: 0.90, green: 0.60, blue: 0.79), location: 0.23),
                        .init(color: Color(red: 0.72, green: 0.42, blue: 0.75), location: 0.55),
                        .init(color: Color(red: 0.51, green: 0.27, blue: 0.62), location: 0.88),
                        .init(color: Color(red: 0.43, green: 0.22, blue: 0.57), location: 1.00)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .allowsHitTesting(false)

                Circle()
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: Color(red: 1.00, green: 0.74, blue: 0.56), location: 0.00),
                                .init(color: Color(red: 1.00, green: 0.56, blue: 0.56), location: 0.45),
                                .init(color: Color(red: 0.99, green: 0.40, blue: 0.62), location: 1.00)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: sunDiameter, height: sunDiameter)
                    .offset(x: sunX, y: sunY)
                    .blur(radius: 0.8)
                    .allowsHitTesting(false)

                Circle()
                    .fill(Color(red: 1.0, green: 0.52, blue: 0.67).opacity(0.20))
                    .frame(width: sunDiameter * 1.4, height: sunDiameter * 1.4)
                    .offset(x: sunX, y: sunY)
                    .blur(radius: 14)
                    .allowsHitTesting(false)

                MonumentRealityView()
                    .ignoresSafeArea()
                    .allowsHitTesting(true)

                LinearGradient(
                    stops: [
                        .init(color: Color.white.opacity(0.09), location: 0.00),
                        .init(color: .clear, location: 0.24),
                        .init(color: .clear, location: 1.00)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .allowsHitTesting(false)

                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.42),
                        .init(color: Color(red: 0.81, green: 0.52, blue: 0.82).opacity(0.28), location: 0.67),
                        .init(color: Color(red: 0.69, green: 0.41, blue: 0.72).opacity(0.74), location: 1.00)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .allowsHitTesting(false)

                Ellipse()
                    .fill(Color(red: 0.75, green: 0.48, blue: 0.79).opacity(0.35))
                    .frame(width: width * 1.8, height: height * 0.44)
                    .offset(y: height * 0.34)
                    .blur(radius: 24)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                RadialGradient(
                    colors: [Color.clear, Color(red: 0.44, green: 0.21, blue: 0.55).opacity(0.32)],
                    center: .center,
                    startRadius: min(width, height) * 0.28,
                    endRadius: max(width, height) * 0.95
                )
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
        }
    }
}
