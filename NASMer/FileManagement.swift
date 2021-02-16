//
//  AppDelegate.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/11.
//

import Foundation
/*
import Cocoa

extension NSOpenPanel {
    
    static func openASM(completion: @escaping (_ result: Result<NSImage, Error>) -> ()) {
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose an image | Our Code World";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = false;
        dialog.allowedFileTypes        = ["png", "jpg", "jpeg", "gif"];

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file

            if (result != nil) {
                let path: String = result!.path
                
                // path contains the file path e.g
                // /Users/ourcodeworld/Desktop/tiger.jpeg
            }
            
        } else {
            // User clicked on "Cancel"
            return
        }

    }
}


extension NSSavePanel {
    
    static func saveASM(_ image: NSString, completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
        
        
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = getCNDate()+".asm"
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        savePanel.begin { (result) in
            guard result == .OK,
                let url = savePanel.url else {
                completion(.failure(
                    NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])
                ))
                return
            }
         
            
        }
        
    }
    static  func getCNDate()-> String {
         let dformatter = DateFormatter()
         
         dformatter.dateFormat = "yyyyMMddHHmmss"
         
         let datestr = dformatter.string(from: Date())
         return datestr
         
     }
}
*/



