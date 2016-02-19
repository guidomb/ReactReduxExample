//
//  Redux.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/17/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol Dispatcher {
    
    typealias Action
    
    func dispatch(action: Action)
    
}

protocol StoreType {
    
    typealias State
    typealias Action
    
    
    var state: AnyProperty<State> { get }
    
    var actions: Signal<Action, NoError> { get }
    
    init(initialState: State, reducer: (State, Action) -> State)
    
}


class Store<Action, State>: StoreType, Dispatcher {
    
    typealias Reducer = (State, Action) -> State
    typealias PartialReducer = (State, Action) -> State?
    
    private let _state: MutableProperty<State>
    let state: AnyProperty<State>
    
    private let (_actions, _dispatcher) = Signal<Action, NoError>.pipe()
    var actions: Signal<Action, NoError> {
        return _actions
    }
    
    
    required init(initialState: State, reducer: Reducer) {
        _state = MutableProperty(initialState)
        state = AnyProperty(_state)
        _state <~ _actions.map { [unowned self] action in reducer(self.state.value, action) }
    }
    
    convenience init(initialState: State, reducers: [PartialReducer]) {
        self.init(initialState: initialState, reducer: combineReducers(reducers))
    }
    
    
    func dispatch(action: Action) {
        _dispatcher.sendNext(action)
    }
    
    
    
}

private func combineReducers<State, Action>(reducers: [(State, Action) -> State?]) -> (State, Action) -> State {
    return { state, action in
        for partialReducer in reducers {
            if let newState = partialReducer(state, action) {
                return newState
            }
        }
        return state
    }
}
