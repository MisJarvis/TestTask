//
//  MainView.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    internal var didAppear: ((Self) -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .opacity(0.1)
                    .ignoresSafeArea()
                    .tag("main_background")
                
                VStack(alignment: .center) {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 10)
                        .background(LinearGradient(
                            colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        .tag("main_background_navbar")
                    
                    if viewModel.people.isEmpty {
                        Text("Failed to load people list")
                            .font(.title)
                        
                        Button {
                            viewModel.fetchPeople()
                        } label: {
                            Label("Try again", systemImage: "arrow.clockwise")
                        }
                    } else {
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.people.sorted(by: >), id: \.key) { id, name in
                                    NavigationLink {
                                        DetailsView(personId: id)
                                    } label: {
                                        HStack {
                                            Label(name, systemImage: "folder")
                                                .padding()
                                                .tag("main_label_person")
                                            Spacer()
                                        }
                                    }
                                    .tag("main_navlink")
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .navigationTitle("People List")
                .font(.title2)
                .foregroundColor(.black)
                .background(.clear)
            }
        }
        .accentColor(.black)
        .onAppear { self.didAppear?(self) }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
        
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
#endif
