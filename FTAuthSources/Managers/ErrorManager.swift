//
//  ErrorManager.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

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
            if let msg = errorModel.message, let key = errorModel.key {
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

enum ErrorType: Decodable {

    case model(errorModel: FTErrorModel), string(errorString: String), stringArray(errorStringArray: [String])

    init(from decoder: Decoder) throws {
        //выяснить почему не распознается модель
        if let model = try? decoder.singleValueContainer().decode(FTErrorModel.self) {
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

