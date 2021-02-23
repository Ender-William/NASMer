//
//  TerminalTask.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/20.
//

import Foundation
import Cocoa
import Combine

/*---------------------------------------------------------------------
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
---------------------------------------------------------------------*/
func runShell(_ command: String, needAuthorize: Bool) -> (isSuccess: Bool, executeResult: String?,commandreturn: String) {
    let scriptWithAuthorization = """
    do shell script "\(command)" with administrator privileges
    """
    
    let scriptWithoutAuthorization = """
    do shell script "\(command)"
    """
    
    let script = needAuthorize ? scriptWithAuthorization : scriptWithoutAuthorization
    let appleScript = NSAppleScript(source: script)
    
    var error: NSDictionary? = nil
    let result = appleScript!.executeAndReturnError(&error)
    if let error = error {
        let commandReturn = ("执行 \n\(command)\n命令出错:\n\(error)")
        return (false, nil, commandReturn)
    }
    
    return (true, result.stringValue, "Compile Finish")
}
