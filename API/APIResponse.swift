//
//  APIResponse.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

protocol APIResponse {
    var request: APIRequest { get }
}

extension APIResponse {
    
    func responseSimpleData(completionHandler: @escaping (_ responseData: Data?, _ error: NSError?) -> Void) {
//        showRequestLogs()
        
        //добавить URLSession
        
        
//        return Observable.create { observer -> Disposable in
//            Alamofire.request(self.request.url, method: self.request.httpMethod, parameters: self.request.body, encoding: JSONEncoding.default, headers: self.request.header)
//                .validate()
//                .responseData(completionHandler: { (response) in
//                    switch response.result {
//                    case .success:
//                        if let data = response.data {
//                            self.showSuccessLogs(with: data)
//                            observer.onNext(data)
//                        } else {
//                            observer.onError(response.error ?? GeneralError.unknown)
//                            return
//                        }
//                    case .failure(let error):
//                        if let statusCode = response.response?.statusCode  {
//                            error.printError(with: statusCode)
//                        }
//                        observer.onError(error)
//                        self.showFailureLogs(with: error)
//                    }
//            })
//            return Disposables.create()
//        }
    }
    
// MARK: - Logs
    
//    private func showRequestLogs() {
//        print("""
//            ✴️✴️✴️✴️✴️⬇️
//            URL: \(request.url);
//            HTTP METHOD: \(request.httpMethod);
//            BODY: \(request.body ?? [:]);
//            HEADER: \(request.header ?? [:]);
//            ⬆️✴️✴️✴️✴️✴️
//            """)
//    }
//
//    private func showSuccessLogs(with data: Data) {
//        do {
//            let decoded = try JSONSerialization.jsonObject(with: data, options: [])
//            if let dictFromJSON = decoded as? [String: AnyObject] {
//                print("""
//                    ✅✅✅✅✅⬇️ Success Data Response (url = \(self.request.url)):
//                    \(dictFromJSON)
//                    ⬆️✅✅✅✅✅
//                    """)
//            }
//        } catch (let error) {
//            showFailureLogs(with: error)
//        }
//    }
//
//    private func showFailureLogs(with error: Error) {
//        print("""
//            ❌❌❌❌❌⬇️ Failure Response (url = \(self.request.url)):
//            \(error.localizedDescription)"
//            ⬆️❌❌❌❌❌
//            """)
//    }
}
