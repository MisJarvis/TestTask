//
//  TestTaskApp.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import SwiftUI

@main
struct TestTaskApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(MainViewModel(networkingService: APIService(executor: NetworkRequestExecutor())))
        }
    }
}
