//
//  DetailsView.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    private var personId: String
    
    init(personId: String) {
        self.personId = personId
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.green
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 10)
                        .background(LinearGradient(
                            colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: geometry.size.width / 3,
                            height: geometry.size.height / 3)
                    
                    Text(viewModel.person.firstName + " " + viewModel.person.firstName)
                        .font(.title)
                    
                    VStack(alignment: .leading) {
                        Label("Age: \(viewModel.person.age)", systemImage: "bolt.heart")
                        Label("Gender: \(viewModel.person.gender)", systemImage: "face.smiling")
                        Label("Country: \(viewModel.person.country)", systemImage: "globe.europe.africa")
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
        DetailsView(personId: String())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
        
        DetailsView(personId: String())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
#endif
