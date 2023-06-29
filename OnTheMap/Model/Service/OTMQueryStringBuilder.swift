//
//  OTMQueryStringBuilder.swift
//  OnTheMap
//
//  Created by MacBook Pro on 29.06.23.
//

import Foundation

protocol IOTMQueryParamStringBuilder {
    func buildGetStudentLocationQueryParamString(limit: Int?, skip: Int?, orderBy: String?, asc: Bool, uniqueKey: String?) -> String
}

class OTMQueryStringBuilder: IOTMQueryParamStringBuilder {
    func buildGetStudentLocationQueryParamString(limit: Int? = nil, skip: Int? = nil, orderBy: String? = nil, asc: Bool = true, uniqueKey: String? = nil) -> String {
        var result: String = "?"
        if let limit = limit {
            result += "limit=\(limit)&"
        }
        if let skip = skip {
            result += "skip=\(skip)&"
        }
        if let orderBy = orderBy {
            result += "order=\(asc ? "" : "-")\(orderBy)&"
        }
        if let uniqueKey = uniqueKey {
            result += "uniqueKey=\(uniqueKey)&"
        }
        return String(result.dropLast())
    }
}
