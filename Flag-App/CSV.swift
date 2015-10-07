//
//  CSV.swift
//  SwiftCSV
//
//  Created by naoty on 2014/06/09.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import Foundation

public class CSV {
    public var headers: [String] = []
    public var rows: [Dictionary<String, String>] = []
    public var columns = Dictionary<String, [String]>()
    var delimiter = NSCharacterSet(charactersInString: ",")
    
    public init(content: String?, delimiter: NSCharacterSet, encoding: UInt) throws{
        if let csvStringToParse = content{
            self.delimiter = delimiter

            let newline = NSCharacterSet.newlineCharacterSet()
            var lines: [String] = []
            csvStringToParse.stringByTrimmingCharactersInSet(newline).enumerateLines { line, stop in lines.append(line) }

            self.headers = self.parseHeaders(fromLines: lines)
            self.rows = self.parseRows(fromLines: lines)
            self.columns = self.parseColumns(fromLines: lines)
        }
    }
    
    public convenience init(contentsOfURL url: NSURL, delimiter: NSCharacterSet, encoding: UInt) throws {
        let csvString: String?
        do {
            csvString = try String(contentsOfURL: url, encoding: encoding)
        } catch _ {
            csvString = nil
        };
        try self.init(content: csvString,delimiter:delimiter, encoding:encoding)
    }
    
    public convenience init(contentsOfURL url: NSURL) throws {
        let comma = NSCharacterSet(charactersInString: ",")
        try self.init(contentsOfURL: url, delimiter: comma, encoding: NSUTF8StringEncoding)
    }
    
    public convenience init(contentsOfURL url: NSURL, encoding: UInt) throws {
        let comma = NSCharacterSet(charactersInString: ",")
        try self.init(contentsOfURL: url, delimiter: comma, encoding: encoding)
    }
    
    public convenience init?(contentsOfFile path: String, delimiter: NSCharacterSet, encoding: UInt) throws {
        var csvString: String? = nil
        do {
            csvString = try String(contentsOfFile: path, encoding: encoding)
        } catch _ {
            csvString = nil
        }
        try self.init(content: csvString, delimiter:delimiter, encoding:encoding)
    }
    
    public convenience init?(contentsOfFile path: String, error: NSErrorPointer) throws {
        let comma = NSCharacterSet(charactersInString: ",")
        try self.init(contentsOfFile: path, delimiter: comma, encoding: NSUTF8StringEncoding)
    }
    
    public convenience init?(contentsOfFile path: String, encoding: UInt, error: NSErrorPointer) throws {
        let comma = NSCharacterSet(charactersInString: ",")
        try self.init(contentsOfFile: path, delimiter: comma, encoding: encoding)
    }
    
    func parseHeaders(fromLines lines: [String]) -> [String] {
        return lines[0].componentsSeparatedByCharactersInSet(self.delimiter)
    }
    
    func parseRows(fromLines lines: [String]) -> [Dictionary<String, String>] {
        var rows: [Dictionary<String, String>] = []
        
        for (lineNumber, line) in lines.enumerate() {
            if lineNumber == 0 {
                continue
            }
            
            var row = Dictionary<String, String>()
            let values = line.componentsSeparatedByCharactersInSet(self.delimiter)
            for (index, header) in self.headers.enumerate() {
                if index < values.count {
                    row[header] = values[index]
                } else {
                    row[header] = ""
                }
            }
            rows.append(row)
        }
        
        return rows
    }
    
    func parseColumns(fromLines lines: [String]) -> Dictionary<String, [String]> {
        var columns = Dictionary<String, [String]>()
        
        for header in self.headers {
            let column = self.rows.map { row in row[header] != nil ? row[header]! : "" }
            columns[header] = column
        }
        
        return columns
    }
}

//The MIT License (MIT)
//
//Copyright (c) 2014 Naoto Kaneko
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.