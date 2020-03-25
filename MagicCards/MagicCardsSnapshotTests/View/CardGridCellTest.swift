//
//  CardGridCellTest.swift
//  MagicCardsSnapshotTests
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Nimble
import Nimble_Snapshots
import XCTest

@testable import MagicCards

final class CardGridCellTest: XCTestCase {

    // MARK: - Variables

    var sut: CardGridCell!

    // MARK: - Methods

    // MARK: Set up

    override func setUp() {
        self.sut = CardGridCell(frame: CGRect(x: 0, y: 0, width: 85, height: 118))
    }

    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Tests

    func testLookAndFeelWithImage() {
        let card = Card(id: "1669af17-d287-5094-b005-4b143441442f",
                        name: "Abundance",
                        imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card",
                        types: ["Enchantment"])
        self.sut.configure(with: CardCellViewModel(card: card))

        expect(self.sut) == snapshot("CardGridCell_withImage")
    }

    func testLookAndFeelWithoutImage() {
        self.sut.configure(with: CardCellViewModel(card: Card(id: "1669af17-d287-5094-b005-4b143441442f",
                                                              name: "Abundance",
                                                              imageUrl: nil,
                                                              types: ["Enchantment"])))

        expect(self.sut) == snapshot("CardGridCell_withoutImage")
    }
}
