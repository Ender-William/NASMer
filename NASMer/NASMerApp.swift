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
        .commands{
                   Menu()
                }
        
        
        WindowGroup{
            CompileView()
                .frame(width: 400, height: 200)
                .preferredColorScheme(.dark)
        }
    }
}

struct Menu:Commands {
    var body: some Commands{
        CommandMenu("My Menu"){
            Button("menu1"){
                print("menu1")
            }
        }
    }
}
