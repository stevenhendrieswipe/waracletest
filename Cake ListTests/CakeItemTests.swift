//
//  CakeItemTests.swift
//  Cake ListTests
//
//  Created by Steven Hendrie on 19/02/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import XCTest



class CakeItemTests: XCTestCase {

    func testModelParsing() {
        
        let testResponse = """
        [{
        "title": "cake-title-1",
        "desc": "cake-desc-1",
        "image": "cake-image.png"
        }]
        """
        guard let jsonData = testResponse.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let networkController = NetworkController()
        let cakeController = CakeController(networkController: networkController)
        
        let cakes = cakeController.parseCakes(data: jsonData)
        
        XCTAssert(cakes.count == 1)
        XCTAssert(cakes[0].title == "cake-title-1")
        XCTAssert(cakes[0].description == "cake-desc-1")
        XCTAssert(cakes[0].imageURL == "cake-image.png")
        
    }
}
