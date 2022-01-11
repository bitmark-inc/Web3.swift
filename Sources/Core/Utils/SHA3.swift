//
//  SHA3.swift
//
//
//  Created by Ho Hien on 8/9/18.
//  Copyright © 2018 Bitmark. All rights reserved.
//

import Foundation
import keccak

public extension Data {
    var sha3_keccak256: Data {
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 32)
        defer {
            result.deallocate()
        }
        
        self.withUnsafeBytes({ (ptr: UnsafeRawBufferPointer) -> Void in
            let input = ptr.baseAddress?.bindMemory(to: UInt8.self, capacity: self.count)
            keccak_256(result, 32, input, self.count)
        })
        
        return Data(bytes: result, count: 32)
    }
    
    var bytes: [UInt8] {
        var array = Array<UInt8>(repeating: 0, count: self.count/MemoryLayout<UInt8>.stride)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
    
    func toHexString() -> String {
      `lazy`.reduce(into: "") {
        var s = String($1, radix: 16)
        if s.count == 1 {
          s = "0" + s
        }
        $0 += s
      }
    }
}

public extension String {

    var bytes: Array<UInt8> {
      data(using: String.Encoding.utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }
    
    var sha3_keccak256: String {
        Data(self.bytes).sha3_keccak256.toHexString()
    }
}
