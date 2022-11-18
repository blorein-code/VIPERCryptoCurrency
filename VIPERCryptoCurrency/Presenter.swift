//
//  Presenter.swift
//  VIPERCryptoCurrency
//
//  Created by Berke Topcu on 18.11.2022.
//

import Foundation
// Class, protocol
// Talks -> Interactor, router, view 

/*
 Her katman ile iletişim halinde olan 
 */

/*
 Presenter'ın olayı, interactor'da bir şeyi download ettiğimiz zaman örneğin (Kripto paraları)
  ve sonrasında View'a kendini güncellemesi gerektiğini söyleyeceğiz.
 */


enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result:Result<[Crypto],Error>)
}

class CryptoPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let crypto):
            //view.update
            view?.update(with: crypto)
        case .failure(_):
            //view.update error
            view?.update(with: "Try again later...")
        }
    }
    
    
}
