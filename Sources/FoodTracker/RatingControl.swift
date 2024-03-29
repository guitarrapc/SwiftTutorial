//
//  RatingControl.swift
//  FoodTracker
//
//  Created by guitarrapc on 2017/11/08.
//  Copyright © 2017年 guitarrapc All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    // MARK: Properties
    private var ratingButtons = [UIButton]()

    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    // MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the rating Buttons array: \(ratingButtons)")
        }

        // Calculate the rating of the selected button
        let selectedRating = index + 1

        if selectedRating == rating {
            // Ig the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }

    // MARK: Private Methods
    private func setupButtons() {

        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()

        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = R.image.filledStar(compatibleWith: self.traitCollection)
        let emptyStar = R.image.emptyStar(compatibleWith: self.traitCollection)
        let highlightedStar = R.image.highlightedStar(compatibleWith: self.traitCollection)

        for index in 0..<starCount {

            // Create the button
            let button = UIButton()

            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])

            // Add Constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true

            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"

            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)

            // Add the button to the stack
            addArrangedSubview(button)

            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of button is less than the rating, that button should be selected
            button.isSelected = index < rating

            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to rest the rating to zero"
            } else {
                hintString = nil
            }

            // Calculate the value string
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }

            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
