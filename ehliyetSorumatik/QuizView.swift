import SwiftUI

struct QuizView: View {
    @ObservedObject var vm: QuestionViewModel
    
    var body: some View {
        ZStack {
            // Arka plan gradyanı (StartView ile uyumlu renkler)
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "0ab6f8"),
                    Color(hex: "ed2d53")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Soru numarası
                Text("Soru \(vm.currentIndex + 1) / 545 ")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                // Soru metni
                ScrollView {
                    Text(vm.currentQuestion?.question ?? "Yükleniyor...")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    
                    // Soru görseli varsa göster
                    if let imageName = vm.currentQuestion?.image, UIImage(named: imageName) != nil {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                    }
                    
                    
                  
                    
                    
                    
                    // Şıklar
                    VStack(spacing: 15) {
                        ForEach(vm.currentQuestion?.options.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { key, value in
                            Button(action: {
                                vm.submitAnswer(key)
                            }) {
                                HStack {
                                    Text("\(key))")
                                        .font(.headline)
                                        .bold()
                                        .frame(width: 30)
                                        .foregroundColor(.white)
                                    
                                    if UIImage(named: value) != nil {
                                        Image(value)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 80)
                                            .cornerRadius(8)
                                    } else {
                                        Text(value)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(nil)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(buttonBackgroundColor(key: key))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                            }
                            .disabled(vm.answerSubmitted)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Sonraki Soru Butonu
                    if vm.answerSubmitted {
                        Button(action: {
                            vm.nextQuestion()
                        }) {
                            Text("Sonraki Soru")
                                .font(.title3)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(hex: "0ab6f8"),
                                            Color(hex: "ed2d53")
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.black)
                                .cornerRadius(15)
                                .shadow(radius: 8)
                                .padding(.horizontal)
                                .padding(.top, 20)
                        }
                    }
                }
            }
        }
    }
    
    // Buton arka plan renkleri: Doğru yeşil, yanlış kırmızı, diğerleri mavi tonu
    func buttonBackgroundColor(key: String) -> Color {
        guard vm.answerSubmitted, let selected = vm.selectedAnswer, let question = vm.currentQuestion else {
            return Color(hex: "3d8bff") // seçilmemiş şıklar için açık mavi
        }
        if key == question.answer {
            return Color.green.opacity(0.8)
        } else if key == selected {
            return Color.red.opacity(0.8)
        } else {
            return Color(hex: "3d8bff")
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(vm: QuestionViewModel())
    }
}

