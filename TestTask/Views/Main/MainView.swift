//
//  MainView.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModelImpl
    
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
                    
                    switch viewModel.currentState {
                    case .empty:
                        emptyStateView
                    case .list:
                        listStateView
                    case .error:
                        errorStateView
                    }
                    Spacer()
                }
                .navigationTitle("main_title")
                .font(.title2)
                .foregroundColor(.black)
                .background(.clear)
            }
        }
        .errorAlert(error: $viewModel.error)
        .accentColor(.black)
    }
}

extension MainView {
    private var emptyStateView: some View {
        VStack(alignment: .center) {
            Image(systemName: "list.bullet.rectangle.portrait")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: .screenWidth / 3,
                    height: .screenHeight / 3)
                .tag("main_image_empty_list")
            
            Text("main_text_empty")
                .font(.title)
        }
    }
    
    private var listStateView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.people.sorted(by: >), id: \.key) { id, name in
                    NavigationLink {
                        DetailsView(viewModel: DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor())), personId: id)
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
    
    private var errorStateView: some View {
        VStack(alignment: .center) {
            Text("main_text_error")
                .font(.title)
            
            Button {
                viewModel.fetchPeople()
            } label: {
                Label("main_text_try_again", systemImage: "arrow.clockwise")
            }
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor())))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
        
        MainView(viewModel: MainViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor())))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
#endif
