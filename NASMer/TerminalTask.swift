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
*   通过调用nasm编译器来完成汇编文件的编译
*
*   输入:command【命令行内容】
*   输入:outputpath【编译完成之后的文件输出地址】
*
*   返回:返回当前指令的运行情况
*
*   创建日期:2021-01-22
*
-------------------------------------------------------------*/


func runShell(_ command: String,_ outputpath: String) -> String {
    let launch_path = DATAModel.NasmData.nasmcompath
    //let launch_path = DATAModel.NasmData.ShellPath
    
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-f","macho64",command,"-o",outputpath]
    task.launchPath = launch_path
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}

