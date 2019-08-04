//
//  AutoLayoutWrapper.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

precedencegroup Constraint {
    higherThan: AdditionPrecedence, ConstraintPriority
}
precedencegroup ConstraintPriority {
    lowerThan: AdditionPrecedence
}

infix operator ||= : Constraint
infix operator ||>= : Constraint
infix operator ||<= : Constraint
infix operator + : AdditionPrecedence
infix operator - : AdditionPrecedence
infix operator ~ : ConstraintPriority
postfix operator ||!

@discardableResult
func ||=<T> (lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs, constant: 0)
}

@discardableResult
func ||>=<T> (lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

@discardableResult
func ||<=<T> (lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

@discardableResult
func + (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constant = rhs
    return lhs
}

@discardableResult
func - (lhs: NSLayoutConstraint, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constant = -rhs
    return lhs
}

@discardableResult
func ||= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(equalToConstant: rhs)
}

@discardableResult
func ~ (lhs: NSLayoutConstraint, rhs: Float) -> NSLayoutConstraint {
    lhs.priority = UILayoutPriority(rhs)
    return lhs
}

@discardableResult
postfix func ||! (constraint: NSLayoutConstraint) -> NSLayoutConstraint {
    constraint.isActive = true
    return constraint
}

struct AutoLayoutWrapper {
    private let view: UIView

    init(_ view: UIView) {
        self.view = view
    }

    @discardableResult
    func centerHorizontally(to view: UIView) -> NSLayoutConstraint {
        return (self.view.centerXAnchor ||= view.centerXAnchor)||!
    }

    @discardableResult
    func centerVertically(to view: UIView) -> NSLayoutConstraint {
        return (self.view.centerYAnchor ||= view.centerYAnchor)||!
    }

    @discardableResult
    func center(to view: UIView) -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
        let xConstraint = centerHorizontally(to: view)
        let yConstraint = centerVertically(to: view)
        return (x: xConstraint, y: yConstraint)
    }

    @discardableResult
    func setTop(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.topAnchor ||= view.bottomAnchor + padding ~ priority)||!
    }

    @discardableResult
    func setLeft(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.leftAnchor ||= view.rightAnchor + padding ~ priority)||!
    }

    @discardableResult
    func setBottom(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.bottomAnchor ||= view.topAnchor + padding ~ priority)||!
    }

    @discardableResult
    func setRight(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.rightAnchor ||= view.leftAnchor - padding ~ priority)||!
    }

    @discardableResult
    func alignTop(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.topAnchor ||= view.topAnchor + padding ~ priority)||!
    }

    @discardableResult
    func alignLeft(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.leftAnchor ||= view.leftAnchor + padding ~ priority)||!
    }

    @discardableResult
    func alignBottom(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.bottomAnchor ||= view.bottomAnchor - padding ~ priority)||!
    }

    @discardableResult
    func alignRight(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.rightAnchor ||= view.rightAnchor - padding ~ priority)||!
    }

    @discardableResult
    func setHeight(to height: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.heightAnchor ||= height ~ priority)||!
    }

    @discardableResult
    func setWidth(to width: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        return (self.view.widthAnchor ||= width ~ priority)||!
    }

    @discardableResult
    func setRatio(to ratio: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        return (NSLayoutConstraint(item: view,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .height,
                                   multiplier: ratio,
                                   constant: 0) ~ priority)||!
    }

    @discardableResult
    func alignEdges(to view: UIView, padding: CGFloat = 0, priority: Float = 1000) -> [NSLayoutConstraint] {
        let topConstraint = alignTop(to: view, padding: padding, priority: priority)
        let bottomConstraint = alignBottom(to: view, padding: padding, priority: priority)
        let leftConstraint = alignLeft(to: view, padding: padding, priority: priority)
        let rightConstraint = alignRight(to: view, padding: padding, priority: priority)
        return [topConstraint, bottomConstraint, leftConstraint, rightConstraint]
    }
}

extension UIView {
    var autolayout: AutoLayoutWrapper {
        translatesAutoresizingMaskIntoConstraints = false
        return AutoLayoutWrapper(self)
    }
}
