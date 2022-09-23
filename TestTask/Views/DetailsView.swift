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
        VStack{
        Text(viewModel.person.firstName)
        Text(viewModel.person.lastName)
        Text(viewModel.person.country)
        }
        .onAppear {
            self.viewModel.fetchPeopleList(personId: personId)
        }
    }
}

#if DEBUG
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(personId: String())
    }
}
#endif
