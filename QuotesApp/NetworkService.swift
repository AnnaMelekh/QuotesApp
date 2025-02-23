//
//  NetworkService.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 22.02.2025.
//

import UIKit

protocol NetworkServiceDelegate {
    func didUpdateData(quotes: [QuoteModel])
    func didFailWithError(error: Error)
}

struct NetworkService {
    
    
    var delegate: NetworkServiceDelegate?


    func performRequest() {
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes")!
        var request = URLRequest(url: url)
        request.setValue("37dzcC9ewolb+jdrMMi3ZQ==rm21imKoXto6vJJd", forHTTPHeaderField: "X-Api-Key")
        let session = URLSession(configuration: .default)
            
             let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Ошибка запроса: \(error.localizedDescription)")
                    return
                }
                
                if let safeData = data {
                    if let quoteModel = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateData(quotes: quoteModel)
                        }
                    }
                }
            }
            
             task.resume()
        }
    
    
    func parseJSON(_ quoteData: Data) -> [QuoteModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([QuoteData].self, from: quoteData)
            
            var quotesArray: [QuoteModel] = decodedData.map { quote in
                    QuoteModel(
                        quote: quote.quote,
                        author: quote.author,
                        category: quote.category
                    )
                }

                print(quotesArray) 

                return quotesArray
            
        } catch {
            print("Ошибка декодирования: \(error)")
            return nil
        }
    }
}
