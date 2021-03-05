//
//  TerminalTask.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/20.
//

import Foundation
import Cocoa
import Combine
import ArgumentParser

/*-------------------------------------------------------------
*
*   执行脚本命令
*
*   输入:command【命令行内容】
*   输入:needAutherize【执行脚本时是否需要sudo授权】
*
*   返回:Returns {Bool,String?,String}【程序的执行结果】
*
*   创建日期:2021-01-22
*
-------------------------------------------------------------
func runShell(_ command: String, needAuthorize: Bool) -> (isSuccess: Bool, executeResult: String?,commandreturn: String) {
    let scriptWithAuthorization = """
    do shell script \"export PATH=\"/usr/local/bin:$PATH\";\(command)\" with administrator privileges
    """
    
    let scriptWithoutAuthorization =  "do shell script \(command)"
    
    let script = needAuthorize ? scriptWithAuthorization : scriptWithoutAuthorization
    NSAppleScript(source: "do shell script \"export PATH=\"/usr/local/bin:$PATH\"\"")
    let appleScript = NSAppleScript(source: script)
    
    var error: NSDictionary? = nil
    let result = appleScript!.executeAndReturnError(&error)
    if let error = error {
        let commandReturn = ("执行 \n\(command)\n命令出错:\n\(error)")
        return (false, nil, commandReturn)
    }
    
    return (true, result.stringValue, "Compile Finish")
}*/


func runShell(_ command: String) -> String {
    let launch_path = DATAModel.NasmData.nasmcompath
    //let launch_path = DATAModel.NasmData.ShellPath
    
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-f","bin",command,"-o","/Users/william/Desktop/iplaaaaccc.bin"]
    task.launchPath = launch_path
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}

