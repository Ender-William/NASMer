//
//  NASMerApp.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/1/27.
//

import SwiftUI
import Combine


@main
struct NASMerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        
                .frame(width: 700, height: 600)
                .preferredColorScheme(.dark)
            
        }
        WindowGroup{
            CompileView()
                .frame(width: 400, height: 200)
                .preferredColorScheme(.dark)
        }
    }
}
