//
//  ArrangeViewController.swift
//  X11SwiftScratch
//
//  Created by Don Mag on 10/30/19.
//  Copyright © 2019 Don Mag. All rights reserved.
//

import UIKit

// simple custom view
class MyView: UIView {
	
	// this will hold the "content" of the custom view
	// for this example, it just holds a label
	let theContentView: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .cyan
		return v
	}()
	
	let theLabel: UILabel = {
		let v = UILabel()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .clear
		v.textAlignment = .center
		v.font = UIFont.systemFont(ofSize: 14.0)
		return v
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	func commonInit() -> Void {
		self.backgroundColor = .clear
		
		// add the label to the content view
		theContentView.addSubview(theLabel)
		
		// add the content view to self
		addSubview(theContentView)
		
		NSLayoutConstraint.activate([
			
			// constrain the label to all 4 sides of the content view
			theLabel.topAnchor.constraint(equalTo: theContentView.topAnchor, constant: 0.0),
			theLabel.bottomAnchor.constraint(equalTo: theContentView.bottomAnchor, constant: 0.0),
			theLabel.leadingAnchor.constraint(equalTo: theContentView.leadingAnchor, constant: 0.0),
			theLabel.trailingAnchor.constraint(equalTo: theContentView.trailingAnchor, constant: 0.0),

			// constrain the content view to all 4 sides of self with 5-pts "padding"
			// so when two views are side-by-side, or over-under,
			// the "content views" will have 10-pts spacing
			theContentView.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
			theContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0),
			theContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
			theContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),

		])
	}
	
}

class ArrangeViewController: UIViewController {

	// Add a view button
	let addButton: UIButton = {
		let v = UIButton()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .yellow
		v.setTitleColor(.blue, for: .normal)
		v.setTitleColor(.lightGray, for: .highlighted)
		v.setTitle("Add", for: .normal)
		return v
	}()
	
	// Remove a view button
	let remButton: UIButton = {
		let v = UIButton()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .yellow
		v.setTitleColor(.blue, for: .normal)
		v.setTitleColor(.lightGray, for: .highlighted)
		v.setTitle("Remove", for: .normal)
		return v
	}()
	
	// horizontal stackview to hold the buttons
	let btnsStack: UIStackView = {
		let v = UIStackView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.axis = .horizontal
		v.alignment = .fill
		v.distribution = .fillEqually
		v.spacing = 20
		return v
	}()
	
	// view to hold the added views
	let innerContainerView: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .clear
		v.clipsToBounds = true
		return v
	}()
	
	// view to hold the view holding the added views (allows us to center the resulting layout)
	let outerContainerView: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .clear
		v.clipsToBounds = true
		return v
	}()
	
	// view to hold the outer container...
	let borderContainerView: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .white
		return v
	}()

	// we'll be updating the .constant of these constraints
	var innerWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
	var innerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBlue
		
		// add the buttons to the stack view
		btnsStack.addArrangedSubview(addButton)
		btnsStack.addArrangedSubview(remButton)

		// add inner container to outer container
		outerContainerView.addSubview(innerContainerView)
		
		// add outer container to border container
		borderContainerView.addSubview(outerContainerView)
		
		// add buttons stack to the view
		view.addSubview(btnsStack)
		
		// add border container to the view
		view.addSubview(borderContainerView)
		
		let g = view.safeAreaLayoutGuide

		// initialize inner container width and height constraints
		innerWidthConstraint = innerContainerView.widthAnchor.constraint(equalToConstant: 0.0)
		innerHeightConstraint = innerContainerView.heightAnchor.constraint(equalToConstant: 0.0)
		
		NSLayoutConstraint.activate([
			
			// constrain buttons stack Top / Leading / Trailing with a little "padding"
			btnsStack.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			btnsStack.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			btnsStack.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),

			// buttons height to 35-pts (just for asthetics)
			btnsStack.heightAnchor.constraint(equalToConstant: 35.0),
			
			// constrain border container
			// 40-pts below buttons
			borderContainerView.topAnchor.constraint(equalTo: btnsStack.bottomAnchor, constant: 40.0),
			// 20-pts from view bottom
			borderContainerView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
			// 60-pts Leading and Trailing
			borderContainerView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 60.0),
			borderContainerView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -60.0),
			
			// constrain outer container 5-pts on each side to match arranged view's view-to-view spacing
			outerContainerView.topAnchor.constraint(equalTo: borderContainerView.topAnchor, constant: 5.0),
			outerContainerView.bottomAnchor.constraint(equalTo: borderContainerView.bottomAnchor, constant: -5.0),
			outerContainerView.leadingAnchor.constraint(equalTo: borderContainerView.leadingAnchor, constant: 5.0),
			outerContainerView.trailingAnchor.constraint(equalTo: borderContainerView.trailingAnchor, constant: -5.0),

			// activate inner container width and height constraints
			innerWidthConstraint,
			innerHeightConstraint,

			// keep inner container centered inside outer container
			innerContainerView.centerXAnchor.constraint(equalTo: outerContainerView.centerXAnchor),
			innerContainerView.centerYAnchor.constraint(equalTo: outerContainerView.centerYAnchor),

		])
		
		// add actions for the Add and Delete buttons
		addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
		remButton.addTarget(self, action: #selector(delTapped(_:)), for: .touchUpInside)
		
    }
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		coordinator.animate(alongsideTransition: { _ in
		}) { [unowned self] _ in
			self.arrangeViews()
		}

	}
	
	@objc func addTapped(_ sender: Any?) -> Void {
		
		// instantiate a new custom view and add it to
		// the inner container view
		let v = MyView()
		innerContainerView.addSubview(v)
		v.theLabel.text = "\(innerContainerView.subviews.count)"
		
		// update the arrangement
		arrangeViews()
		
	}

	@objc func delTapped(_ sender: Any?) -> Void {

		// if inner container has at least one custom view
		if let v = innerContainerView.subviews.last {

			// remove it
			v.removeFromSuperview()
			
			// update the arrangement
			arrangeViews()
			
		}
		
	}
	
	func arrangeViews() -> Void {

		// make sure there is at least 1 subview to arrange
		guard innerContainerView.subviews.count > 0 else { return }
		
		// init local vars to use
		// Note: making them all CGFLoats makes it easier to use in expressions - avoids a lot of casting CGFloat(var)
		
		var numCols: CGFloat = 0
		var numRows: CGFloat = 0

		var lastCols: CGFloat = 0
		var lastRows: CGFloat = 0
		var lastW: CGFloat = 0
		var lastH: CGFloat = 0
		
		var finalW: CGFloat = 0
		var finalH: CGFloat = 0
		var finalCols: CGFloat = 0
		var finalRows: CGFloat = 0

		var w: CGFloat = 0
		var h: CGFloat = 0

		// this is the frame we need to fit inside
		let containerWidth: CGFloat = outerContainerView.frame.size.width
		let containerHeight: CGFloat = outerContainerView.frame.size.height
		
		// number of views to arrange
		let numItems: CGFloat = CGFloat(innerContainerView.subviews.count)
		
		// first pass, we calculate based on converting columns to rows
		// start with 1 row containing all views (so, 10 views == 10 columns)
		
		numCols = numItems
		numRows = 1
		
		// get the width and height of a single item
		w = containerWidth / numCols
		h = w * 8.0 / 5.0

		// if the height of a single item (at 5:8 ratio) is too tall to fit
		// we need to start with the height of the container
		if h > containerHeight {
			h = containerHeight
			w = h * 5.0 / 8.0
		}

		// our while loop will manipulate these vars, so save each "last" value
		// inside the loop
		
		lastCols = numCols
		lastRows = numRows
		lastW = w
		lastH = h
		
		// while a single item height * number of rows is less than container height
		// AND number of columds is greater than 1
		// decrement the number of columns and re-calc
		// which will add a row if needed
		while h * numRows < containerHeight, numCols > 1 {
			lastCols = numCols
			lastRows = numRows
			lastW = w
			lastH = h
			numCols -= 1
			numRows = ceil(numItems / numCols)
			w = containerWidth / numCols
			h = w * 8.0 / 5.0
		}
		
		// we now have the size of a single item,
		// and the number of columns and rows,
		// based on columns-to-rows calculations,
		// so save them for comparison
		let pass1W: CGFloat = lastW
		let pass1H: CGFloat = lastH
		let pass1Cols: CGFloat = lastCols
		let pass1Rows: CGFloat = lastRows
		
		// second pass, we calculate based on converting rows to columns
		// start with 1 column containing all views (so, 10 views == 10 rows)
		
		numRows = numItems
		numCols = 1
		
		// get the width and height of a single item
		h = containerHeight / numRows
		w = h * 5.0 / 8.0
		
		// if the width of a single item (at 5:8 ratio) is too wide to fit
		// we need to start with the width of the container
		if w > containerWidth {
			w = containerWidth / numCols
			h = w * 8.0 / 5.0
		}
		
		// our while loop will manipulate these vars, so save each "last" value
		// inside the loop
		
		lastRows = numRows
		lastCols = numCols
		lastH = h
		lastW = w
		
		// while a single item width * number of columns is less than container width
		// AND number of rows is greater than 1
		// decrement the number of rows and re-calc
		// which will add a column if needed
		while w * numCols < containerWidth, numRows > 1 {
			lastRows = numRows
			lastCols = numCols
			lastH = h
			lastW = w
			numRows -= 1
			numCols = ceil(numItems / numRows)
			h = containerHeight / numRows
			w = h * 5.0 / 8.0
		}

		// we now have the size of a single item,
		// and the number of rows and columns,
		// based on rows-to-columns calculations,
		// so save them for comparison
		let pass2W: CGFloat = lastW
		let pass2H: CGFloat = lastH
		let pass2Cols: CGFloat = lastCols
		let pass2Rows: CGFloat = lastRows

		// if second pass item size is greater than first pass item size
		//   use second pass results
		// else
		//   use first pass results
		if pass2H * pass2W > pass1H * pass1W {
			finalW = pass2W
			finalH = pass2H
			finalCols = pass2Cols
			finalRows = pass2Rows
		} else {
			finalW = pass1W
			finalH = pass1H
			finalCols = pass1Cols
			finalRows = pass1Rows
		}
		
		// resulting width and height of the items
		let innerW: CGFloat = finalW * finalCols
		let innerH: CGFloat = finalH * finalRows

		var x: CGFloat = 0.0
		var y: CGFloat = 0.0

		// loop through, doing the actual layout (setting each item's frame)
		innerContainerView.subviews.forEach { v in
			
			v.frame = CGRect(x: x, y: y, width: finalW, height: finalH)
			x += finalW
			if x + finalW > innerW + 1 {
				x = 0.0
				y += finalH
			}
			
		}
		
		// update inner container view's width and height constraints
		innerWidthConstraint.constant = innerW
		innerHeightConstraint.constant = innerH

	}
	
}

/*
func xarrangeViews() -> Void {

guard innerContainerView.subviews.count > 0 else { return }

let numItems: CGFloat = CGFloat(innerContainerView.subviews.count)

let cWidth = innerContainerView.frame.size.width
let cHeight = innerContainerView.frame.size.height

var numCols: CGFloat = numItems
var numRows: CGFloat = 1

var w = cWidth / numCols
var h = w * 8.0 / 5.0

if h > cHeight {
h = cHeight
w = h * 5.0 / 8.0
}

//		var lastCols = numCols
//		var lastRows = numRows
var lastW = w
var lastH = h

while h * numRows <= cHeight, numCols > 1 {
//			lastCols = numCols
//			lastRows = numRows
lastW = w
lastH = h
numCols -= 1
numRows = ceil(numItems / numCols)
w = cWidth / numCols
h = w * 8.0 / 5.0
}

var tmpW = cWidth / numCols
var tmpH = cHeight / numRows



var x: CGFloat = 0.0
var y: CGFloat = 0.0
innerContainerView.subviews.forEach { v in

v.frame = CGRect(x: x, y: y, width: lastW, height: lastH)
x += lastW
if x + lastW > cWidth + 1 {
x = 0.0
y += lastH
}

}

}
*/

class MyCell: UICollectionViewCell {
	@IBOutlet var theLabel: UILabel!
}

class ArrangeCollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	@IBOutlet var theCollectionView: UICollectionView!
	
	var numItems = 0
	
	var itemSize: CGSize = CGSize(width: 50, height: 80)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		theCollectionView.dataSource = self
		theCollectionView.delegate = self
		

	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		if let fl = theCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			itemSize = CGSize(width: 50, height: 80)
			fl.itemSize = itemSize
		}
		
	}
	
	@IBAction func addTapped(_ sender: Any) {
		numItems += 1
		calcSize()
	}
	
	@IBAction func delTapped(_ sender: Any) {
		if numItems > 1 {
			numItems -= 1
			calcSize()
		}
	}
	
	func calcSize() -> Void {

		// make sure there is at least 1 subview to arrange
		guard numItems > 0 else { return }
		
		// init local vars to use
		// Note: making them all CGFLoats makes it easier to use in expressions - avoids a lot of casting CGFloat(var)
		
		var numCols: CGFloat = 0
		var numRows: CGFloat = 0
		
		var lastCols: CGFloat = 0
		var lastRows: CGFloat = 0
		var lastW: CGFloat = 0
		var lastH: CGFloat = 0
		
		var finalW: CGFloat = 0
		var finalH: CGFloat = 0
		var finalCols: CGFloat = 0
		var finalRows: CGFloat = 0
		
		var w: CGFloat = 0
		var h: CGFloat = 0
		
		// this is the frame we need to fit inside
		let containerWidth: CGFloat = theCollectionView.frame.size.width
		let containerHeight: CGFloat = theCollectionView.frame.size.height
		
		// number of views to arrange
//		let numItems: CGFloat = CGFloat(innerContainerView.subviews.count)
		
		// first pass, we calculate based on converting columns to rows
		// start with 1 row containing all views (so, 10 views == 10 columns)
		
		let localNumItems = CGFloat(numItems)
		
		numCols = localNumItems
		numRows = 1
		
		// get the width and height of a single item
		w = containerWidth / numCols
		h = w * 8.0 / 5.0
		
		// if the height of a single item (at 5:8 ratio) is too tall to fit
		// we need to start with the height of the container
		if h > containerHeight {
			h = containerHeight
			w = h * 5.0 / 8.0
		}
		
		// our while loop will manipulate these vars, so save each "last" value
		// inside the loop
		
		lastCols = numCols
		lastRows = numRows
		lastW = w
		lastH = h
		
		// while a single item height * number of rows is less than container height
		// AND number of columds is greater than 1
		// decrement the number of columns and re-calc
		// which will add a row if needed
		while h * numRows < containerHeight, numCols > 1 {
			lastCols = numCols
			lastRows = numRows
			lastW = w
			lastH = h
			numCols -= 1
			numRows = ceil(localNumItems / numCols)
			w = containerWidth / numCols
			h = w * 8.0 / 5.0
		}
		
		// we now have the size of a single item,
		// and the number of columns and rows,
		// based on columns-to-rows calculations,
		// so save them for comparison
		let pass1W: CGFloat = lastW
		let pass1H: CGFloat = lastH
		let pass1Cols: CGFloat = lastCols
		let pass1Rows: CGFloat = lastRows
		
		// second pass, we calculate based on converting rows to columns
		// start with 1 column containing all views (so, 10 views == 10 rows)
		
		numRows = localNumItems
		numCols = 1
		
		// get the width and height of a single item
		h = containerHeight / numRows
		w = h * 5.0 / 8.0
		
		// if the width of a single item (at 5:8 ratio) is too wide to fit
		// we need to start with the width of the container
		if w > containerWidth {
			w = containerWidth / numCols
			h = w * 8.0 / 5.0
		}
		
		// our while loop will manipulate these vars, so save each "last" value
		// inside the loop
		
		lastRows = numRows
		lastCols = numCols
		lastH = h
		lastW = w
		
		// while a single item width * number of columns is less than container width
		// AND number of rows is greater than 1
		// decrement the number of rows and re-calc
		// which will add a column if needed
		while w * numCols < containerWidth, numRows > 1 {
			lastRows = numRows
			lastCols = numCols
			lastH = h
			lastW = w
			numRows -= 1
			numCols = ceil(localNumItems / numRows)
			h = containerHeight / numRows
			w = h * 5.0 / 8.0
		}
		
		// we now have the size of a single item,
		// and the number of rows and columns,
		// based on rows-to-columns calculations,
		// so save them for comparison
		let pass2W: CGFloat = lastW
		let pass2H: CGFloat = lastH
		let pass2Cols: CGFloat = lastCols
		let pass2Rows: CGFloat = lastRows
		
		// if second pass item size is greater than first pass item size
		//   use second pass results
		// else
		//   use first pass results
		if pass2H * pass2W > pass1H * pass1W {
			finalW = pass2W
			finalH = pass2H
			finalCols = pass2Cols
			finalRows = pass2Rows
		} else {
			finalW = pass1W
			finalH = pass1H
			finalCols = pass1Cols
			finalRows = pass1Rows
		}
		
		itemSize = CGSize(width: finalW, height: finalH)
		
		// resulting width and height of the items
		let innerW: CGFloat = finalW * finalCols
		let innerH: CGFloat = finalH * finalRows
		
		var x: CGFloat = 0.0
		var y: CGFloat = 0.0
		
//		// loop through, doing the actual layout (setting each item's frame)
//		innerContainerView.subviews.forEach { v in
//
//			v.frame = CGRect(x: x, y: y, width: finalW, height: finalH)
//			x += finalW
//			if x + finalW > innerW + 1 {
//				x = 0.0
//				y += finalH
//			}
//
//		}
//
//		// update inner container view's width and height constraints
//		innerWidthConstraint.constant = innerW
//		innerHeightConstraint.constant = innerH

//		if let fl = theCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//			var w = theCollectionView.frame.width / CGFloat(numItems)
//			var h = w * 8.0 / 5.0
//			if h > theCollectionView.frame.height {
//				h = theCollectionView.frame.height
//				w = h * 5.0 / 8.0
//			}
//			itemSize = CGSize(width: w, height: h)
//		}

		
		theCollectionView.reloadData()
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		print(itemSize)
		return itemSize
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print(numItems)
		return numItems
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
		cell.theLabel.text = "\(indexPath.item + 1)"
		return cell
	}
	
	
	
	
}
