//
//  DistanceComponent.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import UIKit
import Neon

final class DistanceComponent: UIView, Component {
    
    private let _titleLabel = UILabel()
    private let _distanceLabel = UILabel()
    
    var properties: DistanceViewModel {
        didSet {
            if shouldUpdate(oldValue) {
                render()
            }
        }
    }
    
    init(properties: DistanceViewModel = DistanceViewModel()) {
        self.properties = properties
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(distance: Float) {
        self.init(properties: DistanceViewModel(distance: distance))
    }
    
    override func configureView() {
        configureSubViews()
        
        _titleLabel.anchorToEdge(.Top, padding: 8, width: width, height: height * 0.10)
        _distanceLabel.alignAndFill(align: .UnderCentered, relativeTo: _titleLabel, padding: 8)
    }
    
    func render() {
        _titleLabel.text = properties.title
        _distanceLabel.text = properties.formattedDistance
    }
    
}

private extension DistanceComponent {
    
    func configureSubViews() {
        addSubview(_titleLabel)
        addSubview(_distanceLabel)
        
        configureTitleView()
        configureDistanceView()
    }
    
    func configureTitleView() {
        _titleLabel.numberOfLines = 1
        _titleLabel.adjustsFontSizeToFitWidth = true
        _titleLabel.textAlignment = .Center
        _titleLabel.backgroundColor = UIColor.blueColor()
    }
    
    func configureDistanceView() {
        _distanceLabel.numberOfLines = 1
        _distanceLabel.adjustsFontSizeToFitWidth = true
        _distanceLabel.textAlignment = .Center
        _distanceLabel.backgroundColor = UIColor.grayColor()
        _distanceLabel.font = UIFont.systemFontOfSize(60)
    }
    
}