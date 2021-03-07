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
        //这俩是用于刷新组件而使用的--------------------------------
        static let showWindows = true
        static let show = false
        //-----------------------------------------------------
        
        
        //NASM编译器路径-----------------------------------------
        static let nasmcompath:String = "/usr/local/bin/nasm"
        static let ShellPath = "/usr/local/bin/nasm"
        //-----------------------------------------------------

        
        //打开文件后的具体文件地址，包含file://的具体文件路径----------
        static let filename = ""
        //-----------------------------------------------------
        //打开文件后的具体文件地址，不包含file://的文件路径------------
        static let Openfilepath = ""
        //-----------------------------------------------------
        
        
        //编辑区域的内容-----------------------------------------
        static let nasminside = ";////可以愉快地在这里写汇编了\n;////本软件使用的编译器是NASM\n;////编码格式为UTF-8"
        //-----------------------------------------------------

        
        //用来反馈操作结果的变量-----------------------------------
        static let commandresult = ""
        //-----------------------------------------------------
        
        
        //编译完成后的文件输出地址---------------------------------
        static let nasmcomoutputpath = ""
        //----------------------------------------------------
        
        
        //编译器的编译格式---------------------------------------
        static let CompileFormatPicker = ""
        
        //如何来编译文件
        static let HowToCompile = ""
        
        //调用nasm编译器的shell命令
        static let ShellCommand = ""
        
    }
    
    //操作执行后的状态
    struct CommandResult {
        //反馈文件地址
        static let OpenFilePath = "[Operation Message: File Path]"
        
        //反馈文件的保存路径
        static let SaveFilePath = "[Operation Message: Save path of file]"
        
        //反馈文件编码格式错误
        static let Formaterror = "[Document State: Format Error]"
        
        
    }
}
