import SwiftUI

struct ContentView: View {
    @StateObject var vm = QuestionViewModel()
    @State private var startQuiz = false
    
    var body: some View {
        NavigationView {
            if startQuiz {
                QuizView(vm: vm)
                    .navigationBarTitle("Soru \(vm.currentIndex + 1)", displayMode: .inline)
            } else {
                StartView(startQuiz: $startQuiz)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

