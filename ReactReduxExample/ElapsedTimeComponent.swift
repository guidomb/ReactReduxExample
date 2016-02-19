//
//  ElapsedTimeComponent.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import UIKit
import Neon

final class ElapsedTimeComponent: UIView, Component {
    
    private let _titleLabel = UILabel()
    private let _elapsedTimeLabel = UILabel()
    
    var properties: ElapsedTimeViewModel {
        didSet {
            if shouldUpdate(oldValue) {
                render()
            }
        }
    }
    
    var elapsedTime: Int {
        get {
            return properties.elapsedTime
        }
        set {
            properties = ElapsedTimeViewModel(elapsedTime: newValue)
        }
    }
    
    init(properties: ElapsedTimeViewModel = ElapsedTimeViewModel()) {
        self.properties = properties
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureView() {
        configureSubViews()
        
        _titleLabel.anchorToEdge(.Top, padding: 8, width: width, height: height * 0.10)
        _elapsedTimeLabel.alignAndFill(align: .UnderCentered, relativeTo: _titleLabel, padding: 8)
    }
    
    func render() {
        _titleLabel.text = properties.title
        _elapsedTimeLabel.text = properties.formattedElapsedTime
    }
    
}

private extension ElapsedTimeComponent {
    
    func configureSubViews() {
        addSubview(_titleLabel)
        addSubview(_elapsedTimeLabel)
        
        configureTitleView()
        configureElapsedTimeView()
    }
    
    func configureTitleView() {
        _titleLabel.numberOfLines = 1
        _titleLabel.adjustsFontSizeToFitWidth = true
        _titleLabel.textAlignment = .Center
        _titleLabel.backgroundColor = UIColor.blueColor()
    }
    
    func configureElapsedTimeView() {
        _elapsedTimeLabel.numberOfLines = 1
        _elapsedTimeLabel.adjustsFontSizeToFitWidth = true
        _elapsedTimeLabel.textAlignment = .Center
        _elapsedTimeLabel.backgroundColor = UIColor.grayColor()
        _elapsedTimeLabel.font = UIFont.systemFontOfSize(60)
    }
    
}