//
//  GenericDataProvider.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import Foundation

protocol GenericDataProvider {
    func success(model: Any)
    func errorData(_ provide: GenericDataProvider?, error: Error)
}


class DataProviderManager<T, S> {
    var delegate: T?
    var model: S?
}
