//
//  HomeView.swift
//  FunMultiplication
//
//  Created by Diana Dashinevich on 21/02/2025.
//
import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let num1: Int
    let num2: Int
    var answer: Int {
        num1 * num2
    }
}

struct MultiplicationGroup {
    let number: Int
    var questions: [Question] {
        (1...10).map { Question(num1: number, num2: $0) }
    }
}

class MultiplicationViewModel: ObservableObject {
    @Published var selectedGroups: Set<Int> = []
    @Published var numberOfQuestions: Int = 5
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var userAnswer = ""
    @Published var score = 0
    @Published var showScore = false
    
    let allGroups = (2...10).map { MultiplicationGroup(number: $0) }
    
    func generateQuestions() {
        questions = allGroups
            .filter { selectedGroups.contains($0.number) }
            .flatMap { $0.questions }
            .shuffled()
            .prefix(numberOfQuestions)
            .map { $0 }
        
        currentQuestionIndex = 0
        score = 0
        showScore = false
        userAnswer = ""
    }
    
    func checkAnswer() {
        guard currentQuestionIndex < questions.count else { return }
        
        let correctAnswer = questions[currentQuestionIndex].answer
        if let userInput = Int(userAnswer), userInput == correctAnswer {
            score += 1
        }
        
        userAnswer = ""
        
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            showScore = true
        }
    }
}

struct HomeView: View {
    @ObservedObject var viewModel: MultiplicationViewModel

    var body: some View {
        VStack {
            if viewModel.showScore {
                Text("Quiz Complete!")
                    .font(.largeTitle)
                    .padding()
                Text("Your Score: \(viewModel.score)/\(viewModel.questions.count)")
                    .font(.title)
                    .padding()
                Button("Try Again") {
                    viewModel.generateQuestions()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            } else {
                if !viewModel.questions.isEmpty {
                    let question = viewModel.questions[viewModel.currentQuestionIndex]

                    Text("\(question.num1) × \(question.num2) = ?")
                        .font(.largeTitle)
                        .padding()

                    TextField("Answer", text: $viewModel.userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                        .multilineTextAlignment(.center)
                        .padding()

                    Button("Next") {
                        viewModel.checkAnswer()
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
        }
        .navigationTitle("Multiplication Quiz")
    }
}


