//
//  AutoLayoutWrapper.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

precedencegroup Constraint {
    higherThan: ConstraintAdditive
}
precedencegroup ConstraintAdditive {
    higherThan: ConstraintPriority
}
precedencegroup ConstraintPriority {}

infix operator |=| : Constraint
infix operator |+| : ConstraintAdditive
infix operator |-| : ConstraintAdditive
infix operator |~| : ConstraintPriority

@discardableResult
func |=|<T> (lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs, constant: 0)
    constraint.isActive = true
    return constraint
}

@discardableResult
func |+| (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constant = rhs
    return lhs
}

@discardableResult
func |-| (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constant = -rhs
    return lhs
}

@discardableResult
func |=| (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalToConstant: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
func |~| (lhs: NSLayoutConstraint, rhs: Float) -> NSLayoutConstraint {
    lhs.priority = UILayoutPriority(rhs)
    return lhs
}

struct AutoLayoutWrapper {
    private let view: UIView

    init(_ view: UIView) {
        self.view = view
    }

    @discardableResult
    func center(to view: UIView) -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
        let xConstraint = self.view.centerXAnchor |=| view.centerXAnchor
        let yConstraint = self.view.centerYAnchor |=| view.centerYAnchor
        return (x: xConstraint, y: yConstraint)
    }

    @discardableResult
    func alignEdges(to view: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        let topConstraint = self.view.topAnchor |=| view.topAnchor |+| padding
        let bottomConstraint = self.view.bottomAnchor |=| view.bottomAnchor |+| padding
        let leftConstraint = self.view.leftAnchor |=| view.leftAnchor |+| padding
        let rightConstraint = self.view.rightAnchor |=| view.rightAnchor |+| padding
        return [topConstraint, bottomConstraint, leftConstraint, rightConstraint]
    }
}

extension UIView {
    var autolayout: AutoLayoutWrapper {
        return AutoLayoutWrapper(self)
    }
}
