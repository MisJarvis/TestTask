//
//  DetailsView.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: DetailsViewModelImpl
    var personId: String
    
    var body: some View {
        ZStack {
            Color.green
                .opacity(0.1)
                .ignoresSafeArea()
                .tag("details_background")
            
            VStack(alignment: .center) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(LinearGradient(
                        colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .tag("details_background_navbar")
                
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
            .navigationBarTitleDisplayMode(.inline)
            .font(.title2)
            .foregroundColor(.black)
            .background(.clear)
        }
        .errorAlert(error: $viewModel.error)
        .onAppear {
            self.viewModel.fetchPerson(personId: personId)
        }
    }
}

extension DetailsView {
    private var emptyStateView: some View {
        VStack(alignment: .center) {
            Image(systemName: "list.bullet.rectangle.portrait")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: .screenWidth / 3,
                    height: .screenHeight / 3)
                .tag("details_image_empty_list")
            
            Text("details_text_empty")
                .font(.title)
        }
    }
    
    private var listStateView: some View {
        VStack(alignment: .center) {
            if let person = viewModel.person {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: .screenWidth / 3,
                        height: .screenHeight / 3)
                    .tag("details_image_person")
                
                Text(person.firstName + " " + person.firstName)
                    .font(.title)
                    .tag("details_full_name_person")
                
                VStack(alignment: .leading) {
                    Label("details_label_age".localized + String(person.age), systemImage: "bolt.heart")
                        .tag("details_age_person")
                    Label("details_label_gender".localized + person.gender, systemImage: "face.smiling")
                        .tag("details_gender_person")
                    Label("details_label_country".localized + person.country, systemImage: "globe.europe.africa")
                        .tag("details_country_person")
                }
                .padding()
            }
        }
    }
    
    private var errorStateView: some View {
        VStack(alignment: .center) {
            Text("details_text_error")
                .font(.title)
            
            Button {
                viewModel.fetchPerson(personId: personId)
            } label: {
                Label("details_text_try_again", systemImage: "arrow.clockwise")
            }
        }
    }
}

#if DEBUG
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor())), personId: String())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
        
        DetailsView(viewModel: DetailsViewModelImpl(dataFetchable: APIService(executor: NetworkRequestExecutor())), personId: String())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
#endif
