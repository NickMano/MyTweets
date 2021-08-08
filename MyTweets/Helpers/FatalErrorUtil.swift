//
//  FatalErrorUtil.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 08/08/2021.
//

func fatalError(_ message: @autoclosure () -> String = "",
                file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

struct FatalErrorUtil {
    // Closure which provides the implementation of fatalError. By default, it uses the one provided by Swift.
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    // Default fatalError implementation provided by Swift.
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    // Static method to replace the fatalError implementation with a custom one
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    // Restores the fatalError implementation with the default one
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
