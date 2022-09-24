//
//  DetailsView.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: MainViewModel
    private var personId: String
    
    init(viewModel: MainViewModel, personId: String) {
        self.viewModel = viewModel
        self.personId = personId
    }
    
    var body: some View {
        GeometryReader { geometry in
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
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: geometry.size.width / 3,
                            height: geometry.size.height / 3)
                        .tag("details_image_person")
                    
                    Text(viewModel.person.firstName + " " + viewModel.person.firstName)
                        .font(.title)
                        .tag("details_full_name_person")
                    
                    VStack(alignment: .leading) {
                        Label("Age: \(viewModel.person.age)", systemImage: "bolt.heart")
                            .tag("details_age_person")
                        Label("Gender: \(viewModel.person.gender)", systemImage: "face.smiling")
                            .tag("details_gender_person")
                        Label("Country: \(viewModel.person.country)", systemImage: "globe.europe.africa")
                            .tag("details_country_person")
                    }
                    .padding()
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .font(.title2)
                .foregroundColor(.black)
                .background(.clear)
            }
        }
        .onAppear {
            self.viewModel.fetchPerson(personId: personId)
        }
    }
}

#if DEBUG
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: MainViewModel(networkingService: APIService(executor: NetworkRequestExecutor())), personId: String())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
        
        DetailsView(viewModel: MainViewModel(networkingService: APIService(executor: NetworkRequestExecutor())), personId: String())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
#endif
