//
//  TerminalTask.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/20.
//

import Foundation
import Cocoa
import Combine
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
/*
@discardableResult
func runShell(_ command: String) -> String {
    
    let task = Process()
    let pipe = Pipe()
    
    task.launchPath = DATAModel.NasmData.ShellPath
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c",command]
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    
    
    return output
}
 */

/*
@discardableResult
func runShell(_ args: [String]) -> String {
    let task = Process()
    task.launchPath = "/usr/bin/bash"
    task.arguments = args

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    task.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String

    return output;
}

//print(shell(["ls", "-al"]));
*/

/// 执行脚本命令
///
/// - Parameters:
///   - command: 命令行内容
///   - needAuthorize: 执行脚本时,是否需要 sudo 授权
/// - Returns: 执行结果



