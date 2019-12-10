//
//  API.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 09.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

//APIUrl
import Foundation

enum ServerType: String {
    #if DEBUG
    case auth = ""
    case main = "http://citybox-api.pieware.pro"
    #else
    case auth = ""
    case main = "http://citybox-api.pieware.pro"
    #endif

}

enum APIFolder: String {
    case api = "api"
}

enum APIVersion: String {
    case v1 = "v1"
}

let SERVER_URL = "\(ServerType.main.rawValue)/\(APIFolder.api.rawValue)/\(APIVersion.v1.rawValue)"
let AUTH_SERVER_URL = "\(ServerType.auth.rawValue)"



//API
import Foundation

class API {
    
    enum Auth {
        case authorization(_ email: String, _ password: String)
        case registration(_ email: String, _ password: String)
        case logout
    }
}

//APIHeader
import Foundation
import Alamofire

struct APIHeader {
    
    enum HeaderKey: String, CaseIterable {
        case token = "Authorization"
    }
    
    static func save(value: Any, key: HeaderKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func recieve(key: HeaderKey) -> String {
        guard let value = UserDefaults.standard.value(forKey: key.rawValue) else { return "" }
        return value as! String
    }
    
    static func remove() {
        for key in HeaderKey.allCases {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    static func setHeader() -> HTTPHeaders {
        var headers = HTTPHeaders()
        for key in HeaderKey.allCases {
            var bearer = "Bearer "
            bearer.append(APIHeader.recieve(key: key))
            headers[key.rawValue] = bearer
        }
        return headers
    }
}

//APIRequest
import Foundation
import Alamofire

struct APIRequest {
    
    let url: String
    let httpMethod: HTTPMethod
    let body: [String: AnyObject]?
    let header: HTTPHeaders?
    let imageData: [String: Data]?
    
    static func createRequest(url: String, httpMethod: HTTPMethod, body: [String: AnyObject]? = nil, header: HTTPHeaders? = nil, imageData: [String: Data]? = nil) -> APIRequest {
        return self.init(url: url, httpMethod: httpMethod, body: body, header: header, imageData: imageData)
    }
}


//APIResponse

import Foundation
import Alamofire
import RxSwift

protocol APIResponse {
    var request: APIRequest { get }
}

extension APIResponse {
    
    func responseSimpleData() -> Observable<Data> {
        showRequestLogs()
        return Observable.create { observer -> Disposable in
            Alamofire.request(self.request.url, method: self.request.httpMethod, parameters: self.request.body, encoding: JSONEncoding.default, headers: self.request.header)
                .validate()
                .responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            self.showSuccessLogs(with: data)
                            observer.onNext(data)
                        } else {
                            observer.onError(response.error ?? GeneralError.unknown)
                            return
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode  {
                            error.printError(with: statusCode)
                        } //else {
                           // observer.onError(GeneralError.unknown)
                        //}
                        observer.onError(error)
                        self.showFailureLogs(with: error)
                    }
            })
            return Disposables.create()
        }
    }
    
    func responseSimpleMultipartData() -> Observable<Data> {
        showRequestLogs()
        return Observable.create { observer in
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageData = self.request.imageData {
                    for (key, value) in imageData {
                        multipartFormData.append(value, withName: "\(key)", fileName: "\(key).png", mimeType: "image/png")
                    }
                }
                if let params = self.request.body {
                    for (key, value) in params {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: "\(key)")
                    }
                }
            }, usingThreshold: UInt64.init(),
               to: self.request.url,
               method: self.request.httpMethod,
               headers: self.request.header,
               encodingCompletion: { result in
                switch result {
                case .success(request: let upload, _, _):
                    upload.responseJSON { response in
                        if let error = response.error as NSError? {
                            error.printError(with: error.code)
                        } else if let data = response.data {
                            self.showSuccessLogs(with: data)
                            observer.onNext(data)
                        } else {
                            observer.onError(response.error ?? GeneralError.unknown)
                            return
                        }
                    }
                case .failure(let error):
                    observer.onError(error)
                    self.showFailureLogs(with: error)
                }
            })
            return Disposables.create()
        }
    }
    
    private func showRequestLogs() {
        print("""
            ✴️✴️✴️✴️✴️⬇️
            URL: \(request.url);
            HTTP METHOD: \(request.httpMethod);
            BODY: \(request.body ?? [:]);
            HEADER: \(request.header ?? [:]);
            ⬆️✴️✴️✴️✴️✴️
            """)
    }
    
    private func showSuccessLogs(with data: Data) {
        do {
            let decoded = try JSONSerialization.jsonObject(with: data, options: [])
            if let dictFromJSON = decoded as? [String: AnyObject] {
                print("""
                    ✅✅✅✅✅⬇️ Success Data Response (url = \(self.request.url)):
                    \(dictFromJSON)
                    ⬆️✅✅✅✅✅
                    """)
            }
        } catch (let error) {
            showFailureLogs(with: error)
        }
    }
    
    private func showFailureLogs(with error: Error) {
        print("""
            ❌❌❌❌❌⬇️ Failure Response (url = \(self.request.url)):
            \(error.localizedDescription)"
            ⬆️❌❌❌❌❌
            """)
    }
}

//NSError+ConsoleOutput

import Foundation

extension Error {
    
    func printError(with code: Int) {
        print("❌ Error code: \(code):")
        switch code {
        case 300...308:
            print("Redirection Error ❌")
        case 400:
            print("Bad Request Error ❌")
        case 401:
            print("Unauthorized Error ❌")
        case 402:
            print("Payment Required Error ❌")
        case 403:
            print("Not enough permissions to perform this action Error ❌")
        case 404:
            print("Client not found Error ❌")
        case 405...420:
            print("Some Client Error ❌")
        case 422:
            print("Error: \(self.localizedDescription) ❌")
        case 423...499:
            print("Some Client Error ❌")
        case 500...599:
            print("Some Server Error ❌")
        default:
            print("Unknown Error ❌")
        }
    }
}

//ErrorManager
import Foundation

struct ErrorManager {
    
    static func errorHandler(_ errorType: ErrorType) -> String {
        switch errorType {
        case .model(let errorModel):
            //уточнить у бэка какие ошибки будут на этапе авторизации и в соответствии этого изменить блок ниже
            if let msg = errorModel.message, let key = errorModel.code {
                switch msg {
                case "required":
                    return "Field \(key) are required!"
                case "invalid":
                    return "The username or password you entered is incorrect."
                case "exists":
                    return "This email already exists."
                case "too_short":
                    return "Password must be at least 8 symbols."
                default:
                    return "Server error"
                }
            } else {
                return "Server error"
            }
        case .string(let errorString):
            switch errorString {
            case "internal_server_error":
                return "Internal Server Error"
            default:
                return errorString
            }
            
        case .stringArray(let errorStringArray):
            return errorStringArray.first ?? "Server error"
        }
    }
    
    static func decodingError(_ error: Error) -> String {
        var errorText = ""
        if let error = error as? DecodingError {
            switch error {
            case DecodingError.dataCorrupted(let context):
                errorText = "Decoding Error: \(DecodingError.dataCorrupted(context))"
                print("❌ Decoding Error: \(DecodingError.dataCorrupted(context)) ❌")
            case DecodingError.keyNotFound(let key, let context):
                errorText = "Decoding Error: \(DecodingError.keyNotFound(key,context))"
                print("❌ Decoding Error: \(DecodingError.keyNotFound(key,context)) ❌")
            case DecodingError.typeMismatch(let type, let context):
                errorText = "Decoding Error: \(DecodingError.typeMismatch(type,context))"
                print("❌ Decoding Error: \(DecodingError.typeMismatch(type,context)) ❌")
            case DecodingError.valueNotFound(let value, let context):
                errorText = "Decoding Error: \(DecodingError.valueNotFound(value,context))"
                print("❌ Decoding Error: \(DecodingError.valueNotFound(value,context)) ❌")
            default:
                errorText = "Decoding Error: \(error.localizedDescription)"
                print("❌ Decoding Error: \(error.localizedDescription) ❌")
            }
        } else {
            errorText = "Decoding Error: \(error.localizedDescription)"
            print("❌ Decoding Error: \(error.localizedDescription) ❌")
        }
        return errorText
    }
}

//GeneralError
enum GeneralError: Error {
    case notFound
    case unknown
    case missingValue
    case noSuccessKey
    case network
    case remoteServer
    case errorType(ErrorType)
    case decodingError(Error)
    case simpleError(Error)
    
    var msg: String {
        switch self {
        case .notFound:
            return "Not found"
        case .unknown:
            return "Unknown"
        case .missingValue:
            return "Missing Value"
        case .noSuccessKey:
            return "No 'success' key in response from server"
        case .network:
            return "Network error"
        case .remoteServer:
            return "Remote server error"
        case .errorType(let errorType):
            return ErrorManager.errorHandler(errorType)
        case .decodingError(let error):
            return ErrorManager.decodingError(error)
        case .simpleError(let error):
            return error.localizedDescription
        }
    }
}

//ErrorModel
import Foundation

struct ErrorModel: Decodable {
    var code: Int?
    var message: String?
}

enum ErrorType: Decodable {
    
    case model(errorModel: ErrorModel), string(errorString: String), stringArray(errorStringArray: [String])
    
    init(from decoder: Decoder) throws {
        if let model = try? decoder.singleValueContainer().decode(ErrorModel.self) {
            self = .model(errorModel: model)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(errorString: string)
            return
        }
        if let stringArray = try? decoder.singleValueContainer().decode([String].self) {
            self = .stringArray(errorStringArray: stringArray)
            return
        }
        throw GeneralError.missingValue
    }
}
