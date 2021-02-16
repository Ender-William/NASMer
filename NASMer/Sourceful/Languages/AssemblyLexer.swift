//
//  AssemblyLexer.swift
//  NASMer
//
//  Created by Willian_Kuang on 2021/2/10.
//

import Foundation

public class AssemblyLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // Functions
        
        generators.append(regexGenerator("\\b(System.out.print|System.out.printL)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("(0x)+(([0-9a-f])+)", tokenType: .number))//十六进制数
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        //NASM常用的指令
        let keywords = "DB DW DD DQ DT DO DY DZ ORG EQU RESB RESW RESDREST RESO RESY RESZ INCBIN AAA AAD AAM AAS ADC ADD AND ARPL BB0_RESET BB1_RESET BOUND BSF BSRBSWAP BT BTC BTR BTS CALL CBW CDQ CDQE CLC CLD CLI CLTS CMC CMP CMPSB CMPSD CMPSQ CMPSW CMPXCHG CMPXCHG486 CMPXCHG8B CMPXCHG16B CPUID CPU_READ CPU_WRITE CQO CWD CWDE DAA DAS DEC DIV DMINT EMMS ENTER WQU F2XM1 FABS FADD FADDP FBLD FBSTP FCHS FCLEX FCMOVB FCMOVBE FCMOVE MOV LEA INC DEC SUB SBB MUL IMUL IDIV JMP JE JZ JNE JNZ JG JNLE JGE JNL JL JNGE JLE JNG JA JNBE JAE JNB JB JNAE JBE JNA JXCE JC JNC JO JNO JP JPE JNP JPO JS JNS LOOP OR XOR TEST NOT SHL SHR SAL SAR ROL ROR RCL RCR SHLD SHRD MOVSB MOVSW MOVSD MOVSQ CLD STD REP RET PUSH POP SCASB SCASW SCASD SCASQ STOSB STOSW STOSD STOSQ LODSB LODSW LODSD LODSQ db dw dd dq dt do dy dz resb resw resdrest reso resy resz incbin aaa aad aam aas adc add and arpl bb0_reset bb1_reset bound bsf bsrbswap bt btc btr bts call cbw cdq cdqe clc cld cli clts cmc cmp cmpsb cmpsd cmpsq cmpsw cmpxchg cmpxchg486 cmpxchg8b cmpxchg16b cpuid cpu_read cpu_write cqo cwd cwde daa das dec div dmint emms enter wqu f2xm1 fabs fadd faddp fbld fbstp fchs fclex fcmovb fcmovbe fcmove mov lea inc dec sub sbb mul imul idiv jmp je jz jne jnz jg jnle jge jnl jl jnge jle jng ja jnbe jae jnb jb jnae jbe jna jxce jc jnc jo jno jp jpe jnp jpo js jns loop or xor test not shl shr sal sar rol ror rcl rcr shld shrd movsb movsw movsd movsq cld std rep ret push pop scasb scasw scasd scasq stosb stosw stosd stosq lodsb lodsw lodsd lodsq equ org".components(separatedBy: " ")
        generators.append(keywordGenerator(keywords, tokenType: .command))
        
        let registerType = "AX AH AL BX BH BL CX CH CL DX DH DL SI DI BP SP EAX EBX ECX EDX EBP ESP ESI EDI EFLAGS EIP CS SS DS ES FS GS RAX RBX RCX RDX RDI RSI RBP RSP R8 R9 R10 R11 R12 R13 R14 R15 ax ah al bx bh bl cx ch cl dx dh dl si di bp sp eax ebx ecx edx ebp esp esi edi eflags eip cs ss ds es fs gs rax rbx rcx rdx rdi rsi rbp rsp r8 r9 r10 r11 r12 r13 r14 r15".components(separatedBy: " ")
        
        generators.append(keywordGenerator(registerType, tokenType: .identifier))
        
        /*let builtInObjectsIdentifiers = "Infinity NaN undefined null globalThis Object Function Boolean Symbol Error AggregateError  EvalError InternalError  RangeError ReferenceError SyntaxError TypeError URIError Number BigInt Math Date String RegExp Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array BigInt64Array BigUint64Array Map Set WeakMap WeakSet ArrayBuffer SharedArrayBuffer  Atomics  DataView JSON Promise Generator GeneratorFunction AsyncFunction Iterator  AsyncIterator  Reflect Proxy Intl Intl.Collator Intl.DateTimeFormat Intl.ListFormat Intl.NumberFormat Intl.PluralRules Intl.RelativeTimeFormat Intl.Locale arguments".components(separatedBy: " ")*/
        
        /*let lamdaFunctions = "__ add addIndex adjust all allPass always and andThen any anyPass ap aperture append apply applySpec applyTo ascend assoc assocPath binary bind both call chain clamp clone comparator complement compose composeK composeP composeWith concat cond construct constructN contains converge countBy curry curryN dec defaultTo descend difference differenceWith dissoc dissocPath divide drop dropLast dropLastWhile dropRepeats dropRepeatsWith dropWhile either empty endsWith eqBy eqProps equals evolve F filter find findIndex findLast findLastIndex flatten flip forEach forEachObjIndexed fromPairs groupBy groupWith gt gte has hasIn hasPath head identical identity ifElse inc includes indexBy indexOf init innerJoin insert insertAll intersection intersperse into invert invertObj invoker is isEmpty isNil join juxt keys keysIn last lastIndexOf length lens lensIndex lensPath lensProp lift liftN lt lte map mapAccum mapAccumRight mapObjIndexed match mathMod max maxBy mean median memoizeWith merge mergeAll mergeDeepLeft mergeDeepRight mergeDeepWith mergeDeepWithKey mergeLeft mergeRight mergeWith mergeWithKey min minBy modulo move multiply nAry negate none not nth nthArg o objOf of omit once or otherwise over pair partial partialRight partition path pathEq pathOr paths pathSatisfies pick pickAll pickBy pipe pipeK pipeP pipeWith pluck prepend product project prop propEq propIs propOr props propSatisfies range reduce reduceBy reduced reduceRight reduceWhile reject remove repeat replace reverse scan sequence set slice sort sortBy sortWith split splitAt splitEvery splitWhen startsWith subtract sum symmetricDifference symmetricDifferenceWith T tail take takeLast takeLastWhile takeWhile tap test thunkify times toLower toPairs toPairsIn toString toUpper transduce transpose traverse trim tryCatch type unapply unary uncurryN unfold union unionWith uniq uniqBy uniqWith unless unnest until update useWith values valuesIn view when where whereEq without xor xprod zip zipObj zipWith".components(separatedBy: " ")*/
               
        //generators.append(keywordGenerator(lamdaFunctions, tokenType: .identifier))
        
        //generators.append(keywordGenerator(builtInObjectsIdentifiers, tokenType: .identifier))
        
        
        
        // Line comment
        generators.append(regexGenerator(";(.*)", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))
        
        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))
        
        // Multi-line string literal
        generators.append(regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        // Editor placeholder
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
