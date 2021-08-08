/*----------------------------------------------------
*   创建日期：2021-01-27
*   NASMerApp.swift
*
*
*
*
*
 ---------------------------------------------------*/
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
