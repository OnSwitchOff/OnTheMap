//
//  OTMUdacityClient.swift
//  OnTheMap
//
//  Created by MacBook Pro on 29.06.23.
//

import Foundation

class OTMUdacityClient {
    
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        case createSession
        
        var stringValue: String {
            switch self {
            case .createSession: return Endpoints.base + "/session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let range = 5..<data.count
                let efficientData = data.subdata(in: range)
                print(String(data: efficientData, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: efficientData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let range = 5..<data.count
                    let efficientData = data.subdata(in: range)
                    let errorResponse = try decoder.decode(OTMResponse.self, from: efficientData) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(name: username, password: password)
        taskForPOSTRequest(url: Endpoints.createSession.url, responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                Auth.sessionId = response.session.id
                print("Auth.sessionId: " + Auth.sessionId)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}



