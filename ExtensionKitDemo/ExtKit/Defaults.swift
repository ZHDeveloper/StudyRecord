//
//  Defaults.swift
//  ExtKit
//
//  Created by ZhiHua Shen on 2018/6/12.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import Foundation

public let ValueDefaults = UserDefaults.standard

public protocol DefaultsKeyable {
    associatedtype Target: Codable
    var key: String { get set }
}

public struct Key<ValueType: Codable>: DefaultsKeyable {
    public typealias Target = ValueType
    public var key: String
    public init(_ key: String) {
        self.key = key
    }
}

extension UserDefaults {
    
    public subscript<T: DefaultsKeyable>(sc: T) -> T.Target? {
        get {
            guard let data = self.data(forKey: sc.key) else {
                return nil
            }
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.Target.self, from: data)
                return decoded
            } catch {
                #if DEBUG
                print(error)
                #endif
                return nil
            }
        }
        set {
            if isSwiftCodableType(T.Target.self) || isFoundationCodableType(T.Target.self) || newValue == nil {
                self.set(newValue, forKey: sc.key)
                return
            }
            do {
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(newValue)
                self.set(encoded, forKey: sc.key)
                self.synchronize()
            } catch {
                #if DEBUG
                print(error)
                #endif
            }
        }
    }
    
    private func isSwiftCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:
            return true
        default:
            return false
        }
    }
    
    private func isFoundationCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is Date.Type:
            return true
        default:
            return false
        }
    }
}
