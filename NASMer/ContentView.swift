//
//  ContentView.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/1/27.
//

import Foundation
import SwiftUI
import Cocoa
import Combine
import UserNotifications


struct ContentView: View {
    
/*--------------------这部分声明了要使用的变量--------------------*/
    
    //这俩是用于刷新组件而使用的--------------------------------
    @State var show = DATAModel.NasmData.show
    @State var showWindows = DATAModel.NasmData.showWindows
    //-----------------------------------------------------
    
    
    //NASM编译器路径-----------------------------------------
    @State var nasmcompath = DATAModel.NasmData.nasmcompath
    @State var ShellPath = DATAModel.NasmData.ShellPath
    //-----------------------------------------------------
    
    
    //打开文件后的具体文件地址，包含file://的具体文件路径----------
    @State var filename = DATAModel.NasmData.filename
    //-----------------------------------------------------
    //打开文件后的具体文件地址，不包含file://的文件路径------------
    @State var Openfilepath = DATAModel.NasmData.Openfilepath
    //-----------------------------------------------------
    
    
    //编辑区域的内容-----------------------------------------
    @State var nasminside = DATAModel.NasmData.nasminside
    //----------------------------------------------------

    
    //用来反馈操作结果的变量----------------------------------
    @State var commandresult = DATAModel.NasmData.commandresult
    //----------------------------------------------------
    
    
    //编译完成后的文件输出地址--------------------------------
    @State var nasmcomoutputpath = DATAModel.NasmData.nasmcomoutputpath
    //---------------------------------------------------
    
    
/*-------------------------变量声明结束-------------------------*/
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                
                //这个就是主界面的那个没有啥实际用途的标题
                Text("Hello, Assembly World！")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                
                //打开编译方法的设定页面
                Button("编译前的设定"){
                    //用来显示一个新的窗口——编译方法设置的一个新窗口
                    let detailView = CompileView()
                    let controller = DetailWC(rootView: detailView)
                    controller.window?.title = "NASMer - How to Compile"
                    controller.showWindow(nil)
                    
                    //刷新组件
                    if (showWindows == true){
                        showWindows = false
                    }else{
                        showWindows = true
                    }
                    
                }
                .allowsHitTesting(false)//用来禁止用户操作此按钮，等待功能完善之后再开放
                
                
                
                //完成打开界面 ，使用NSOpenPanel组件来完成
                Button("\(self.show ? "打开文件":"打开文件")"){
                    
                    let ASMOpener: NSOpenPanel = NSOpenPanel()
                        ASMOpener.prompt = "Open"
                        ASMOpener.worksWhenModal = true
                        ASMOpener.allowsMultipleSelection = false
                        ASMOpener.canChooseDirectories = false
                        ASMOpener.resolvesAliases = true
                        ASMOpener.title = "打开文件"
                        ASMOpener.allowedFileTypes = ["asm","nas"]//可以读取这几种格式的asm文件
                        ASMOpener.runModal()
                    let chosenfile = ASMOpener.url
                        if (chosenfile != nil)
                        {
                            let TheFile = chosenfile!.absoluteString //选择后的文件地址
                            //print(TheFile)  //在控制台输出文件地址方便调试
                            filename = TheFile
                            
                            let fileManager = FileManager.default
                            if let url = URL.init(string: TheFile) {
                                if fileManager.fileExists(atPath: url.path) {
                                    //文件存在
                                    let txtData = fileManager.contents(atPath: url.path)
                                    //如果打开的文件内没有内容，则反馈"空"
                                    if txtData == nil {
                                        //return nil
                                        commandresult = "nil !"
                                    }
                                    //print(txtData as Any) //在控制台输出文件内容，方便调试
                                    //print(txtData!.availableStringEncodings)
                                    
                                    let readString = String(data: txtData!, encoding: String.Encoding.utf8)
                                    
                                    if readString != nil{
                                        //如果解码后的文件内容不为空
                                        //print("readString: \(String(describing: readString))")
                                        nasminside = String(readString!)//使编辑区域显示解码后的内容
                                        //print("nasminside: \(nasminside)")
                                        commandresult = "Read Successful!"//反馈“读取成功”
                                        
                                        var printPath = TheFile
                                        printPath.removeFirst(7)// 移除"file://"
                                        //commandresult = DATAModel.CommandResult.OpenFilePath + printPath
                                        Openfilepath = printPath
                                        printPath.removeLast(3)// 移除文件后缀asm，方便导出编译文件重新定义输出文件格式
                                        nasmcomoutputpath = printPath //定义该文件内容的输出地址
                                        
                                    }else{
                                        //如果解码后的内容为空，则反馈“编码格式错误”
                                        commandresult = "Format error"
                                    }
                                }else {
                                    //文件不存在
                                    print("Path loss file is not exists")
                                    //return nil
                                }
                            }
                            print([])
                        }
                        else
                        {
                            //用户如果点击取消打开文件，则反馈“操作取消”
                            commandresult = "Operation Cancel!"
                        }
                    
                    //用来强制刷新SourceCodeTextEditor组件的
                    //我也不知道为啥必须使用一个关联的逻辑才能刷新那个组件，可能是那个组建的问题吧或者是
                    //苹果的View的刷新机制的问 题吧，艹，简直恶心透了！！！
                    //这个组件千万不能删，删掉了就不能正常刷新了
                    if (showWindows == true){
                        showWindows = false
                    }else{
                        showWindows = true
                    }
                }
                .keyboardShortcut("o", modifiers: [.command])//Command + O 来快捷打开文件
                
                
                
                //完成保存任务，使用NSSavePanel组件来完成操作
                Button("保存"){
                    let ASMSaver:NSSavePanel = NSSavePanel()
                        ASMSaver.prompt = "Save"
                        ASMSaver.worksWhenModal = true
                        ASMSaver.title = "保存文件"
                        ASMSaver.showsTagField = false
                        ASMSaver.nameFieldStringValue = "Untitle"+".asm"
                        ASMSaver.message = "请选择一个文件夹来保存文件"
                        ASMSaver.runModal()
                    let chosenfile = ASMSaver.url
                    if (chosenfile != nil){
                        var Saver = chosenfile!.absoluteString //选择后的文件地址
                        Saver.removeFirst(7)//同样得要移除”file://“这个东西，不然是保存不了的特别神奇
                        //print(Saver)
                        do {
                            try nasminside.write(toFile: Saver, atomically: true, encoding: String.Encoding.utf8)
                            commandresult = "Save Successful"
                        }catch{
                            commandresult = "File did not save"
                        }
   
                    }else{
                        commandresult = "File path can not be nil"
                    }
                }
                .keyboardShortcut("s",modifiers: [.command])
                
                
                
                Button("导出编译文件"){
                    
                    let ShellCommand = String(Openfilepath)//这里是文件的路径，导出前必须得要先保存一下
                    let outputpath = String(nasmcomoutputpath) + "bin"
                    //这里得要解释一下为啥后面要加上bin，因为nasmcomoutputpath这个里面的格式是这个样子的
                    // "/path/path/path/filename."，所以是没有保存格式的，这里的bin就是导出的文件格式
                    //print(Openfilepath)
              
                    commandresult = runShell(ShellCommand,outputpath)//得到操作结果，如果啥都没有就是说明导出成功
                    
                    //老样子是刷新组件用的
                    if (showWindows == true){
                        showWindows = false
                    }else{
                        showWindows = true
                    }
                }
                .keyboardShortcut("e", modifiers: [.command])//快捷键 Command + E 来完成编译
            }
            .frame(width:670,alignment: .leading)//定义这个组件的宽为670px
            
            
            
            Text("Design for editing and compiling assembly")
                .font(.subheadline)
                .foregroundColor(Color.white)
        
            
            
            if(showWindows == true){
                HStack{
                    TextField(ShellPath, text: $ShellPath)
                        .frame(width: 332, height: 30,alignment:.center)
                    TextField(nasmcompath, text: $nasmcompath)
                        .frame(width: 332, height: 30,alignment:.center)
                    
                }
            }else{
                HStack{
                    TextField(ShellPath, text: $ShellPath)
                        .frame(width: 332, height: 30,alignment:.center)
                    TextField(nasmcompath, text: $nasmcompath)
                        .frame(width: 332, height: 30,alignment:.center)
                    
                }
            }
            
            
            //SourceCodeTextEditor组件，用来输入程序源码的部分
            //这个组件是使用开源文本编辑软件中的一部分，用来显示具体的程序行数以及语法高亮
            //原程序中只有Java，JS，Python以及Swift语言的高亮格式
            //通过分析这些文件的组成方式，新建了一个Assembly语言的高亮格式文件
            //这里使用if...else...语句是为了在从文件中打开并加载文件内容后能够让组件正确显示出来文件内容的
            //如果不实用这个语句就无法完成组件的刷新
            //这个应该是原程序的问题，那个开源软件也是不能完成View的刷新
            if(showWindows == true){
                SourceCodeTextEditor(text: $nasminside)
                //TextEditor(text:$nasminside)
                    .frame(width: 670, height: 400.0,alignment:.center)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(.custom("Monaco", size: 16))
            }else{
                SourceCodeTextEditor(text: $nasminside)
                //TextEditor(text:$nasminside)
                    .frame(width: 670, height: 400.0,alignment:.center)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(.custom("Monaco", size: 16))
            }
            
            
            
        
            TextEditor(text: .constant(commandresult)) //使用了text: .constant(String)可以有效地禁止编辑TextEditor的内容
                .frame(width: 670, height:70 ,alignment:.center)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .font(.custom("Monaco", size: 14))
                
                
            
        }
        .frame(minWidth: 670, minHeight: 50,alignment:.leading)
    }
    
}



struct ContentView_Previews: PreviewProvider  {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .frame(width: 700, height: 600)
            .previewDisplayName("NASMer")
    }
}
