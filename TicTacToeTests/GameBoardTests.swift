//
//  GameBoardTests.swift
//  TicTacToeTests
//
//  Created by Jake Connerly on 10/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import TicTacToe //importing the app itself to get access to properties add @testable to get access to ALL properties


class GameBoardTests: XCTestCase {
    var board2 = GameBoard()
    func testCreatingEmptyBoard() {
        let board = GameBoard()
        
        for x in 0..<3 {
            for y in 0..<3 {
                let square = (x, y)
                //XCTAssert returns a bool to let xcode know if the test was good or not
                XCTAssertNil(board[square])
            }
        }
    }
    
    func testPlacingMarks() {
        var board = GameBoard()
        XCTAssertNoThrow(try board.place(mark: .o, on: (0, 0)))
        XCTAssertEqual(board[(0, 0)], .o)
        XCTAssertNoThrow(try board.place(mark: .x, on: (2, 2)))
        XCTAssertEqual(board[(2, 2)], .x)
        for x in 0..<3 {
            for y in 0..<3 {
                if x == 0 && y == 0 { continue }
                if x == 2 && y == 2 { continue }
                XCTAssertNil(board[(x, y)])
            }
        }
        
        XCTAssertThrowsError(try board.place(mark: .x, on: (0, 0))) { (error) in
            XCTAssertEqual(error as? GameBoardError, GameBoardError.invalidSquare)
        }
    }
    
    func testIsFull() {
        var board = GameBoard()
        try! board.place(mark: .x, on: (0, 0))
        try! board.place(mark: .o, on: (0, 1))
        try! board.place(mark: .x, on: (0, 2))
        try! board.place(mark: .o, on: (1, 0))
        try! board.place(mark: .x, on: (1, 1))
        try! board.place(mark: .o, on: (1, 2))
        try! board.place(mark: .x, on: (2, 0))
        try! board.place(mark: .o, on: (2, 1))
        XCTAssertFalse(board.isFull)
        
        try! board.place(mark: .x, on: (2, 2))
        XCTAssertTrue(board.isFull)
    }

}
