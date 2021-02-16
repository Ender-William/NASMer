//
//  CompileSettingWindowConfig.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/10.
//
import Foundation
import SwiftUI
import Cocoa
//import SavannaKit
//import SourceEditor
//import UIKit

//显示编译设定窗口
class DetailWC<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 400, height: 200))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 400, height: 200))
        self.init(window: window)
    }
}
