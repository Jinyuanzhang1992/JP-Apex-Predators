//
//  ContentView.swift
//  JP APex Predators
//
//  Created by Jinyuan Zhang on 06/11/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // 实例化模型
    let predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currenctSelection = PredatorType.all

    var filteredDinos: [ApexPredator] {
        predators.filter(by: currenctSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }

    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(
                        predator: predator,
                        position:
                                .camera(
                                    MapCamera(
                                        centerCoordinate: predator.location,
                                        distance: 30000
                                    )
                        )
                    )
                } label: {
                    HStack {
                        // dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)

                        VStack(alignment: .leading) {
                            // name
                            Text(predator.name)
                                .fontWeight(.bold)

                            // type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 13)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
//            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(placement: .principal) { // 添加标题
                    Text("Main Screen")
                        .font(.headline)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker(
                            "Filter",
                            selection: $currenctSelection.animation()
                        ) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
