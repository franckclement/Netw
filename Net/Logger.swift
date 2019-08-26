/**
 *  Net
 *
 *  Copyright (c) 2019 Franck Clement. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

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
