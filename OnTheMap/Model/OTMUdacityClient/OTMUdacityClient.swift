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
        static var key = ""
        static var objectId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        case createSession
        case getStudentLocations(String)
        case postStudentLocation
        case putStudentLocation(String)
        case deleteSession
        
        var stringValue: String {
            switch self {
            case .createSession: return Endpoints.base + "/session"
            case .getStudentLocations(let queryParams): return Endpoints.base + "/StudentLocation\(queryParams)"
            case .postStudentLocation: return Endpoints.base + "/StudentLocation"
            case .putStudentLocation(let objectId): return Endpoints.base + "/StudentLocation/\(objectId)"
            case .deleteSession: return Endpoints.base + "/session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, offset: Int = 0 ,completion: @escaping (ResponseType?, Error?) -> Void) {
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
                let range = offset..<data.count
                let efficientData = data.subdata(in: range)
                print(String(data: efficientData, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: efficientData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let range = offset..<data.count
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
        taskForPOSTRequest(url: Endpoints.createSession.url, responseType: LoginResponse.self, body: body, offset: 5) { response, error in
            if let response = response {
                Auth.sessionId = response.session.id
                Auth.key = response.account.key
                print("Auth.sessionId: " + Auth.sessionId)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func createNewStudentLocation(firstName: String, lastName: String, mapString: String,
                                        mediaUrl: String, lat: Double, long: Double,
                                        completion: @escaping (Bool, Error?) -> Void) {
        let body = StudentLocation(uniqueKey: Auth.key, firstName: firstName, lastName: lastName, mapString: mapString, mediaUrl: mediaUrl, lat: lat, long: long)
        taskForPOSTRequest(url: Endpoints.postStudentLocation.url, responseType: PostStudentLocationResponse.self, body: body) { response, error in
            if let response = response {
                print("ObjectId: " + response.objectId)
                Auth.objectId = response.objectId
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, offset: Int = 0 ,completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                let range = offset..<data.count
                let efficientData = data.subdata(in: range)
                print(String(data: efficientData, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: efficientData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let range = offset..<data.count
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
    
    class func updateExistingStudentLocation(firstName: String, lastName: String, mapString: String,
                                             mediaUrl: String, lat: Double, long: Double, objectId: String = "",
                                             completion: @escaping (Bool, Error?) -> Void) {
         let objectId = objectId.isEmpty ? Auth.objectId : objectId
         let body = StudentLocation(uniqueKey: Auth.key, firstName: firstName, lastName: lastName, mapString: mapString, mediaUrl: mediaUrl, lat: lat, long: long)
         taskForPUTRequest(url: Endpoints.putStudentLocation(objectId).url, responseType: UpdateExistingStudentLocationResponse.self, body: body) { response, error in
             if let response = response {
                 print("UpdatedAt: " + response.updatedAt)
                 completion(true, nil)
             } else {
                 completion(false, error)
             }
         }
     }
    
    class func taskForDELETERequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, offset: Int = 0 ,completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie}
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let range = offset..<data.count
                let efficientData = data.subdata(in: range)
                print(String(data: efficientData, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: efficientData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let range = offset..<data.count
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
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        taskForDELETERequest(url: Endpoints.deleteSession.url, responseType: LogoutResponse.self, offset: 5) { response, error in
            if let response = response {
                print("SessionId: " + response.session.id)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                print(String(data: data, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OTMResponse.self, from: data) as Error
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
        
        return task
    }
    
    class func getStudentsLocation(queryParams: String, completion: @escaping ([StudentLocation]?, Error?) -> Void) -> URLSessionDataTask {
        let task = taskForGETRequest(url: Endpoints.getStudentLocations(queryParams).url, responseType: StudentLocationResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
        return task
    }
}



