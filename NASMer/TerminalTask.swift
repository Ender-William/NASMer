//
//  TerminalTask.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/20.
//

import Foundation

@discardableResult
func runShellAndOutput(_ command: String) -> (Int32, String?) {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)
    
    task.waitUntilExit()
    
    return (task.terminationStatus, output)
}
