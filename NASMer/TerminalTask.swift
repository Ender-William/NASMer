//
//  TerminalTask.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/20.
//

import Foundation

/*
@discardableResult
func runShell(_ command: String) -> Int32 {
 let task = Process()
 task.launchPath = "/bin/bash"
 task.arguments = [command]
 task.launch()
 task.waitUntilExit()
 return task.terminationStatus
}
*/

@discardableResult
func runShell(_ command: String) -> String {
    
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = [command]
    task.launchPath = "/bin/zsh"
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}
