//
//  DataModel.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/14.
//

import Foundation
import Combine

class DATAModel{
    struct NasmData {
        static let showWindows = true
        static let show = false

        //NASM编译器路径
        static let nasmcompath:String = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"

        //nasm文件的内容
        static let nasminside = ";////可以愉快地在这里写汇编了\n;////本软件使用的编译器是NASM\n;////编码格式为UTF-8"

        static let filename = ""

        //文件地址
        static let Openfilepath = ""
        
        //获取CommandLineTool的返回值
        static let commandresult = ""
        
        //编译器的编译格式
        static let CompileFormatPicker = ""
        
        //编译后的文件的输出地址
        static let nasmcomoutputpath = ""
        
        //如何来编译文件
        static let HowToCompile = ""
        
        //调用nasm编译器的shell命令
        static let ShellCommand = ""
        
        static let ShellPath = "/bin/bash"
        //static let ShellPath = "/usr/local/bin/nasm"
        //static let ShellPath = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"
    }
    
    
    struct CommandResult {
        static let OpenFilePath = "[Operation Message: File Path]"
        
        static let SaveFilePath = "[Operation Message: Save path of file]"
    }
}
