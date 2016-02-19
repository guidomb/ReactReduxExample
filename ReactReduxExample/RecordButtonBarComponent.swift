//
//  RecordButtonBar.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/19/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import UIKit
import Neon

final class RecordButtonBarProperties {
    
    let state: RecordingState
    let onStart: () -> ()
    let onStop: () -> ()
    let onContinue: () -> ()
    let onSave: () -> ()
    
    init(state: RecordingState = .Idle,
        onStart: () -> () = { _ in },
        onStop: () -> () = { _ in },
        onContinue: () -> () = { _ in },
        onSave: () -> () = { _ in }) {
            
        self.state = state
        self.onStart = onStart
        self.onStop = onStop
        self.onContinue = onContinue
        self.onSave = onSave
    }
    
}

final class RecordButtonBarComponent: UIView, Component {
 
    var properties: RecordButtonBarProperties
    
    private let _startButton = UIButton()
    private let _stopButton = UIButton()
    private let _continueButton = UIButton()
    private let _saveButton = UIButton()
    
    init(properties: RecordButtonBarProperties = RecordButtonBarProperties()) {
        self.properties = properties
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        configureButton(_startButton, title: "Start", selector: "onStart")
        configureButton(_stopButton, title: "Stop", selector: "onStop")
        configureButton(_continueButton, title: "Continue", backgroundColor: UIColor.blueColor(), selector: "onContinue")
        configureButton(_saveButton, title: "Save", backgroundColor: UIColor.greenColor(), selector: "onSave")
    }
    
    func render() {
        removeSubviews()
        switch properties.state {
        case .Idle:
            addSubview(_startButton)
            _startButton.fillSuperview()
        case .Recording:
            addSubview(_stopButton)
            _stopButton.fillSuperview()
        case .Paused:
            addSubview(_continueButton)
            addSubview(_saveButton)
            _continueButton.anchorAndFillEdge(.Left, xPad: 0, yPad: 0, otherSize: width / 2)
            _saveButton.alignAndFill(align: .ToTheRightCentered, relativeTo: _saveButton, padding: 0)
        }
    }
    
    func onStart() {
        properties.onStart()
    }
    
    func onStop() {
        properties.onStop()
    }
    
    func onContinue() {
        properties.onContinue()
    }
    
    func onSave() {
        properties.onSave()
    }
    
}

private extension RecordButtonBarComponent {
    
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func configureButton(button: UIButton, title: String, backgroundColor: UIColor = UIColor.redColor(), selector: String) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: Selector(selector), forControlEvents: .TouchUpInside)
    }
    
}
