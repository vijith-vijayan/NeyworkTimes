//
//  Observable.swift
//  NYTimes
//
//  Created by Vijith TV on 29/03/22.
//

import Foundation

class Observable<T> {

    //MARK: - VALUE

    var value: T {
        didSet {
            listener?(value)
        }
    }

    //MARK: - LISTNER CLOSURE

    private var listener: ((T) -> Void)?

    //MARK: - INITIALIZER

    init(_ value: T) {
        self.value = value
    }

    //MARK: - BIND FUNCTION

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
