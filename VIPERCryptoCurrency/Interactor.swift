//
//  Interactor.swift
//  VIPERCryptoCurrency
//
//  Created by Berke Topcu on 18.11.2022.
//

import Foundation
//Class,protocol
// Talks -> Presenter

//Verilerin çekileceği bölüm


protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else {
            return
        }
        //weak self zayıf referans, garbage collector'ın işini kolaylatırmak için
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                //Hata mesajlarını enum olarak tuttuk ve veriyi indirirken hata alıyorum.
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                //Hata mesajlarını enum olarak tuttuk ve veriyi indirdim çevirirken hata alıyorum.
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
    
    
}
