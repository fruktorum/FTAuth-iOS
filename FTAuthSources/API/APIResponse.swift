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
        showRequestLogs()
        guard let url = URL(string: request.url) else { return }
        var sessionRequest = URLRequest(url: url)
        sessionRequest.httpMethod = request.httpMethod
        if let body = request.body, let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            sessionRequest.httpBody = httpBody
            sessionRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let httpHeader = request.header {
            sessionRequest.setValue(httpHeader, forHTTPHeaderField: "session-token")
        }
        let session = URLSession.shared
        session.dataTask(with: sessionRequest) { (data, response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                    self.showFailureLogs(with: error)
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("StatusCode: \(httpResponse.statusCode)")
                // ошибку всегда выводим алертом, если она не от сервера
            }
            print("Response: \(response)")
            
            guard let data = data else { return }
            self.showSuccessLogs(with: data)
            completionHandler(data, error as NSError?)
        }.resume()
    }
    
// MARK: - Logs
    
    private func showRequestLogs() {
        print("""
            ✴️✴️✴️✴️✴️⬇️
            URL: \(request.url);
            HTTP METHOD: \(request.httpMethod);
            BODY: \(request.body ?? [:]);
            HEADER: \(request.header ?? "");
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
