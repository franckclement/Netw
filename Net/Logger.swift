//
//  Logger.swift
//  Net
//
//  Created by Franck Clement on 19/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import os.log

extension OSLog {
    static let netError = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Net-Error")
    static let netInfo = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Net-Info")
}

struct Logger {
    public static func logError(_ message: StaticString, _ args: CVarArg...) {
        os_log(message, log: OSLog.netError, type: .error, args)
    }
    
    public static func logInfo(_ message: StaticString, _ args: CVarArg...) {
        os_log(message, log: OSLog.netInfo, type: .info, args)
    }
}
