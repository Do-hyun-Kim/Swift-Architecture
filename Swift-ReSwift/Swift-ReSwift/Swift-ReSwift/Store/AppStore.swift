//
//  AppStore.swift
//  Swift-ReSwift
//
//  Created by Kim dohyun on 2022/12/28.
//

import ReSwift
import Foundation


//MARK: State
struct AppState {
    public var globalCount: Int = 0
}

//MARK: Action
struct didTapIncrementButton: Action {}
struct didTapDecrementButton: Action {}

//MARK: State Change
func appReducer(_ action: Action, _ state: AppState?) -> AppState {
    guard var state = state else { return .init() }
    
    switch action {
    case is didTapIncrementButton:
        state.globalCount += 1
    case is didTapDecrementButton:
        state.globalCount -= 1
    default:
        break
    }
    return state
}
