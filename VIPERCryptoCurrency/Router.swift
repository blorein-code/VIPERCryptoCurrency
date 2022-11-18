//
//  Router.swift
//  VIPERCryptoCurrency
//
//  Created by Berke Topcu on 18.11.2022.
//

import Foundation
import UIKit

//Class, protocol

/*
 uygulamanın başlayacağı noktayı belirtitğimiz bölüm. Storyboard mevcut olmadığı için burayı kullanıyoruz
 */

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}


class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
       
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
