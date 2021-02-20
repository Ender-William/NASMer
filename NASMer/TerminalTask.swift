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
func runShell(_ args: [String]) -> String {
    let task = Process()
    task.launchPath = "/usr/bin/base"
    task.arguments = args

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    task.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    
    return output;
}
