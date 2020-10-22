//
//  PixabayViewModel.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/16/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import Foundation
import UIKit

extension PixabayViewController {
    func fetchPixbay(for searchKey: String, completion: @escaping (Result<PixaBayModel, Error>) -> Void) {
        guard let escapedTerm = searchKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
           return
        }
        ServiceManager.shared.get(urlString: baseUrl + escapedTerm + type, completionBlock: { result in
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let data):
                let decoder = JSONDecoder()
                do
                {
                    completion(.success(try decoder.decode(PixaBayModel.self, from: data)))
                } catch {
                    let alert = UIAlertController(title: "Skuad", message: "Error Occured", preferredStyle: UIAlertController.Style.alert)
                    let alertAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }   
}
