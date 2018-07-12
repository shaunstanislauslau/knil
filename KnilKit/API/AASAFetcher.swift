//
//  AASAFetcher.swift
//  Knil
//
//  Created by Ethanhuang on 2018/6/25.
//  Copyright © 2018年 Elaborapp Co., Ltd. All rights reserved.
//

import Foundation

public struct AASAFetcher {
    public static func fetch(host: String, completion: @escaping (Result<AASA>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = "/apple-app-site-association"

        guard let url = urlComponents.url else {
            completion(.error(KnilKitError.invalidURLString(host)))
            return
        }

        url.performRequest { (result) in
            switch result {
            case .value(let data):
                do {
                    let aasa = try AASA(data: data)
                    completion(.value(aasa))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}