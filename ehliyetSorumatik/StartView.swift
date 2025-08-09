import SwiftUI

// HEX renk desteği için extension (önceki ile aynı)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Animasyonlu kayan araba view
struct MovingCar: View {
    let imageName: String
    let size: CGSize
    let speed: Double
    @State private var xOffset: CGFloat = -200
    
    var body: some View {
        Image(systemName: imageName) // Eğer kendi resmin varsa Image(imageName) yap
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .foregroundColor(Color.white.opacity(0.7))
            .offset(x: xOffset, y: 0)
            .onAppear {
                withAnimation(
                    Animation.linear(duration: speed)
                        .repeatForever(autoreverses: false)
                ) {
                    xOffset = UIScreen.main.bounds.width + 200
                }
            }
    }
}

struct StartView: View {
    @Binding var startQuiz: Bool
    
    var body: some View {
        ZStack {
            // Gradient Arka Plan
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "0ab6f8"),
                    Color(hex: "ed2d53")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            // Animasyonlu arabalar
            ZStack {
                MovingCar(imageName: "car.fill", size: CGSize(width: 120, height: 70), speed: 35)
                    .offset(y: -150)
                MovingCar(imageName: "car.fill", size: CGSize(width: 90, height: 50), speed: 45)
                    .offset(y: -100)
                MovingCar(imageName: "car.fill", size: CGSize(width: 140, height: 80), speed: 55)
                    .offset(y: -50)
            }
            .opacity(0.6)
            
            VStack(spacing: 40) {
                Spacer()
                
                Text("Ehliyet Teorik Çıkmış \n Sorular")
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(hex: "c11e38"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }

                Spacer()
                
                Text("545 soruluk ehliyet testi ile bilginizi sınamaya hazır mısınız?")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(hex: "c11e38"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        startQuiz = true
                    }
                }) {
                    Text("🚀 Başla")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                        .padding()
                        .frame(maxWidth: 250)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "0ab6f8"),
                                    Color(hex: "c11e38")
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(radius: 10)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(startQuiz: .constant(false))
    }
}

