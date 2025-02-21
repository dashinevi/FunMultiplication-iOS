//
//  SettingsView.swift
//  FunMultiplication
//
//  Created by Diana Dashinevich on 21/02/2025.
//
import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: MultiplicationViewModel

    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("Select Multiplication Groups")
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.allGroups, id: \.number) { group in
                            Button(action: {
                                if viewModel.selectedGroups.contains(group.number) {
                                    viewModel.selectedGroups.remove(group.number)
                                } else {
                                    viewModel.selectedGroups.insert(group.number)
                                }
                            }) {
                                Text("×\(group.number)")
                                    .padding()
                                    .background(viewModel.selectedGroups.contains(group.number) ? Color.yellow : Color.gray)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                
                }

                Text("Number of Questions")
                    .font(.headline)
                    .padding(.top)

                Picker("Number of Questions", selection: $viewModel.numberOfQuestions) {
                    ForEach([5, 10, 15, 20], id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)

                HStack {
                    Spacer()
                    Button("Save & Start") {
                        viewModel.generateQuestions()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    Spacer()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}
