[TOC]

----

# NASMer 下载地址

## [![standard-readme compliant](https://img.shields.io/badge/Beta%20Version-V0.5-brightgreen.svg?style=flat-square)](https://pan.baidu.com/s/1U9E2gp7lEYuUJZobry6Bdw)NASMer V0.5版本下载地址及版本说明



链接:https://pan.baidu.com/s/1U9E2gp7lEYuUJZobry6Bdw   提取码:5fef

系统版本适配：macOS Big Sur （装配有Intel芯片的Mac电脑）

适配的NASM版本：NASM 2.15.03

支持的汇编文件格式：asm  nas

支持的编译格式：macho64

支持的导出文件的格式：bin

版本说明：这个版本算是个Beta版本，很多功能都不太完善，只支持编辑、编译单个文件，后续我还会根据使用情况来进行更新

***PS：这个软件是我用Swift写的第一个软件，是零基础开始写的，一边学一边写，还有很多的不足，望各位大佬可以帮忙来改进这个软件。说一下为什么我要写这个软件，我发现Mac平台没有一个很令我满意的Assembly编辑器，其他的编辑器的功能太多了太复杂了，不够专一，所以我就想写这个软件来进行汇编开发。还希望各位可以来进行改进！！！***

---

# NASMer GitHub文件结构关键内容说明

> Sourceful
>
> > SourceCodeToken.swift
> >
> > Language
> >
> > > AssemblyLexer.swift
> > >
> > > //这个文件内包含了NASMer语法高亮的关键文件
> >
> >  Themes
> >
> > > DefaultSourceCodeTheme.swift
> > >
> > > //这个文件包含了语法高亮色颜色设定代码
> > >
> > > //使用的是NSColor的RGB值
>
> NASMer
>
> > NASMerApp.swift
> >
> > ContentView.swift
> >
> > CompileView.swift
> >
> > CompileSettingWindowConfig.swift
> >
> > DataModel.swift
> >
> > TerminalTask.swift
>
> Products

---

# AssemblyLexer.swift

AssemblyLexer.swift 文件里面包含了有关Assembly语言的关键文字，高亮组件会根据这个文件的内容对ASM代码进行高亮标注。

---

# DefaultSourceCodeTheme.swift

Themes中的DefaultSourceCodeTheme.swift文件里面包含了各类关键字的高亮颜色定义组件

例如

```swift
case .command:
	return NSColor(red: 134/255, green: 193/255, blue: 102/255, alpha: 1.0)
```

这里对command类别的关键字显示 `R134 G193 B102` 这个颜色

假如我想新添加一个类别叫做 extensionCode，我需要在DefaultSourceCodeTheme.swift文件中==**switch** syntaxColorType== 代码段内添加

```swift
case .extensionCode:
	return NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
```

然后再在SourceCodeToken.swift文件中的==**public** **enum** SourceCodeTokenType== 代码段中添加如下代码

```swift
case extensionCode
```

这样这个类别才能够被组件正确的识别到。如果我们想要在***==对应编程语言的关键文字==*** 的文件中使用这个高亮类别，我们得要这样做：

---

## 》在已有的语法高亮文件中添加

在==**lazy** **var** generators: [TokenGenerator] = {......}==代码段中var generators = [TokenGenerator?]() `之后另起新行添加如下代码

```swift
generators.append(regexGenerator([String], tokenType: .extensionCode))

//其中的YourCode可以是一段正则表达式，像是下面的代码
generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))

//或者是很多关键字
//假设有很多关键字的话，我们必须在上述代码前面添加这些关键字，具体的样例代码如下

let KeyWordsInAssembly ="DB DW DD DQ DT DO DY DZ".components(separatedBy:" ")
//这里要注意一点啊，如果这些关键字之间是使用空格来进行分离的，那么结尾的separatedBy后面的双引号内必须要键入空格

//这里给一个完整的多关键字的代码样例
let KeyWordsInAssembly ="DB DW DD DQ DT DO DY DZ".components(separatedBy:" ")
generators.append(regexGenerator(KeyWordsInAssembly, tokenType: .identifier))
//这样子就可以随心所欲地添加关键字了
```

具体的正则表达式的内容如下

### 基本字符 (单个字符)

- 不需要转义的字符

|   类别   |      符号       |
| :------: | :-------------: |
| 大写字母 |  ABCDEF...XYZ   |
| 小写字母 |  abcdef...xyz   |
|   数字   |   0123456789    |
|   其他   | `~!@#%&;:'",<>/ |

- 需要进行转义的其他字符

|       转义方法        |       符号        |
| :-------------------: | :---------------: |
|  双反斜杠转义 『\\』  | $^*()-=+[{]}\|.？ |
| 三反斜杠转义 『\\\\』 |         \         |

### 元字符 (单类字符)

| 符号 |                         类别                          |
| :--: | :---------------------------------------------------: |
|  .   |                 除换行符外的任意字符                  |
| \\w  |               字母、数字、下划线或汉字                |
| \\s  | 任意空白字符,包括换页符、换行符、回车符、制表符、空格 |
| \\d  |                         数字                          |
| \\f  |                        换页符                         |
| \\n  |                        换行符                         |
| \\r  |                        回车符                         |
| \\t  |                        制表符                         |
| \\v  |                      垂直制表符                       |

### 反义(元字)符

| 符号 |             类别              |
| :--: | :---------------------------: |
| \\W  |  非字母、数字、下划线或汉字   |
| \\S  |          非空白字符           |
| \\D  |          非数字字符           |
|  ^   | 非后接的字符,可同时接多个字符 |

### 限定字符

- 接在字符或字符表达式后以对其进行限定修饰

#### 贪婪限定字符

- 当匹配符合多种情况时优先字符数多的情况
  字符串 ："123456789"
  正　则 ："^\d+"
  结　果 ：123456789

| **符号** |                **意义**                |
| :------: | :------------------------------------: |
|    *     | 重复单字符或表达式零次以上（包括零次） |
|    +     | 重复单字符或表达式一次以上（包括一次） |
|    ?     |       重复单字符或表达式零或一次       |
|   {n}    |         重复单字符或表达式n次          |
|   {n,}   |  重复单字符或表达式n次以上（包括n次）  |
|  {n,m}   |        重复单字符或表达式n到m次        |

#### 懒惰限定符

- 当匹配符合多种情况时优先字符数少的情况
  字符串 ："123456789"
  正　则 ："^\d+?"
  结　果 ：1

| **符号** |                **意义**                |
| :------: | :------------------------------------: |
|    *?    | 重复单字符或表达式零次以上（包括零次） |
|    +?    | 重复单字符或表达式一次以上（包括一次） |
|    ??    |       重复单字符或表达式零或一次       |
|  {n,}?   |  重复单字符或表达式n次以上（包括n次）  |
|  {n,m}?  |        重复单字符或表达式n到m次        |

### 定位符

| **符号** |        **意义**        |
| :------: | :--------------------: |
|    ^     |      字符串的开始      |
|    $     |      字符串的结束      |
|   \\b    |     单词开始或结束     |
|   \\B    | 非单词开头或结束的字符 |

### 连接符

| **符号** |                **意义**                 |
| :------: | :-------------------------------------: |
|    \|    | 用于连接两个字符或表达式,可理解为『或』 |
|    ,     |     用于连接两个字符,可理解为『或』     |
|    -     |           用于选取一个字符域            |

### 分隔符

- 对单个字符或表达式等进行分隔

| **符号** |            **意义**             |
| :------: | :-----------------------------: |
|    []    | 单字符分隔符 ：对单字符进行分隔 |
|    ()    | 表达式分隔符 ：对表达式进行分隔 |
|    {}    | 限定符分隔符 ：对限定符进行分隔 |

### 正则实例

- 2到6位字母或数字组成的字符串

|  ^   | [a-z,A-Z,0-9]\|{2,6} |  $   |
| :--: | :------------------: | :--: |
|  首  |   2到6位字母或数字   |  尾  |

- 首字符为字母其余为字母或数字组成的6位及以上字符串

|  ^   | [a-z,A-Z]{1} | [a-z,A-Z,\\d]\|{5,} |  $   |
| :--: | :----------: | :-----------------: | :--: |
|  首  |   1位字母    | 5位及以上字母或数字 |  尾  |

- 邮箱

|  ^   |  [A-Z,a-z,\\d]+   |      ([-_.][A-Za-z\\d]+)*      |  @   |       ([A-Za-z\\d]+[-.])+       | [A-Za-z\\d]{2,4} |  $   |
| :--: | :---------------: | :----------------------------: | :--: | :-----------------------------: | :--------------: | :--: |
|  首  | 0位以上数字或字母 | 0次以上(-_.+0位以上数字或字母) |  @   | 0次以上(0次以上数字或字母 + -.) | 2到4位数字或字母 |  尾  |

### 代码书写

```swift
/// 帐号
var acount = "339662012@qq.com"
/// 正则规则字符串
let pattern = "^[A-Z,a-z,\\d]+([-_.][A-Z,a-z,\\d]+)*@([A-Z,a-z,\\d]+[-.])+[A-Z,a-z,\\d]{2,4}"
/// 正则规则
let regex = try? NSRegularExpression(pattern: pattern, options: [])
/// 进行正则匹配
if let results = regex?.matches(in: acount, options: [], range: NSRange(location: 0, length: acount.count)), results.count != 0 {
    print("帐号匹配成功")
    for result in results{
        let string = (acount as NSString).substring(with: result.range)
        print("对应帐号:",string)
    }
}
```



---

## 》新添加编程语言的语法高亮文件

1. 首先需要在Language文件夹内新建一个Swift文件，文件要统一命名为`LanguageName+Lexer.swift` 这种形式

2. 文档内要有如下的内容

```swift
import Foundation
public class LanguageLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()   
      	//
      	//添加关键字代码或者正则表达式代码
      	//具体的参考上面
      	//
      	//
      	var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}

```

之后往里面添加对应的代码就可以了

---

# ContentView.swift

```swift
//这俩是用于刷新组件而使用的
@State private var showWindows = true
@State private var show = false

//NASM编译器路径
@State var nasmcompath:String = "/usr/local/Cellar/nasm/2.15.05/bin/nasm"

//nasm文件的内容
@State public var nasminside = ";////可以开心地在这里写汇编啦\n;////本软件使用的编译器是NASM\n;////编码格式为UTF-8"

@State var filename = ""

@State var commandresult = "" //获取CommandLineTool的返回值
```

这些代码初始化了要使用的变量

我还没想好这里到底应该要怎么做，好多的组件我还没有搞明白，所以这些个变量后期我还会改。

## 打开新窗口

这里先给放出一个我参考的代码样例:

```swift
import SwiftUI
import Cocoa

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer()
            Button("打开新窗口"){
                let detailView = DetailView()

                let controller = DetailWC(rootView: detailView)
                controller.window?.title = "新窗口"
                controller.showWindow(nil)
            }
            Spacer()
            Divider()
        }
        .frame(width: 600, height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class DetailWC<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 400, height: 500))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 400, height: 500))
        self.init(window: window)
    }
}

struct DetailView: View {
    var body: some View {
        VStack{
            Spacer()
           Text("我是新窗口")
            Spacer()
        }
    }
}
```

////

下面的代码是这次项目当中新建编译设定窗口用到的代码

```swift
let detailView = CompileView()
let controller = DetailWC(rootView: detailView)
controller.window?.title = "NASMer - How to Compile"
controller.showWindow(nil)
if (showWindows == true){
  showWindows = false
}else{
  showWindows = true
}
```

这部分组件是嵌入在Button当中的，为的是新建一个窗口并给新建的窗口命名。

```swift
class DetailWC<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 400, height: 500))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 400, height: 500))
        self.init(window: window)
    }
}
```

这部分文件我保存在了`CompileSettingWindowConfig.swift` 文件里，当然了想保存在`ContentView.swift`文件中也不是不可以主要是想要让代码显得简洁些且便于阅读，所以就单独保存到一个文件中了。

同样的，为了ContentView.swift文件的整洁，我把新建的窗口View：CompileView放入了`CompileView.swift` 

