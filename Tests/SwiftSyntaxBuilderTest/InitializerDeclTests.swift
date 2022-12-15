//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class InitializerDeclTests: XCTestCase {
  func testInitializerDecl() {
    let builder = InitializerDecl("""
      public init(errorCode: Int) {
        self.code = errorCode
      }
      """)
    
    AssertBuildResult(builder, """
      public init(errorCode: Int) {
          self.code = errorCode
      }
      """)
  }
  
  func testFailableInitializerDecl() {
    let builder = InitializerDecl("""
      public init?(errorCode: Int) {
        guard errorCode > 0 else { return nil }
        self.code = errorCode
      }
      """)
    
    AssertBuildResult(builder, """
      public init?(errorCode: Int) {
          guard errorCode > 0 else {
              return nil
          }
          self.code = errorCode
      }
      """)
  }
}
