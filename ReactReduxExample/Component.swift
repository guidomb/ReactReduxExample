//
//  Component.swift
//  ReactReduxExample
//
//  Created by Guido Marucci Blas on 1/18/16.
//  Copyright © 2016 guidomb. All rights reserved.
//

import UIKit

protocol Renderable {
    
    func render()
    
}

protocol ViewAttachable {
    
    var attachableView: UIView { get }
    
    func configureView()
    
}

typealias RenderableAttachableView = protocol<Renderable, ViewAttachable>

protocol Component: Renderable {
    
    typealias Properties
    
    var properties: Properties { get set }
    
    func shouldUpdate(properties: Properties) -> Bool
    
}

extension Component where Properties: Equatable {
    
    func shouldUpdate(properties: Properties) -> Bool {
        return self.properties != properties
    }
    
}


extension Component where Properties: AnyObject {
    
    func shouldUpdate(properties: Properties) -> Bool {
        return self.properties !== properties
    }
    
}

extension UIView: ViewAttachable {
    
    var attachableView: UIView {
        return self
    }
    
    func configureView() {
        
    }
    
}

class ContainerComponent: UIViewController {
    
    private let _renderables: [RenderableAttachableView]
    
    init(renderables: [RenderableAttachableView] = []) {
        _renderables = renderables
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildComponents()
    }
    
    // Template method
    func applySubviewsLayout() {}
    
    // Template method
    func performStateBinding() {}
    
    final func bindState() {
        if isViewLoaded() {
            executeInMainThread(performStateBinding)
        }
    }
    
}

private extension ContainerComponent {
    
    func setUpChildComponents() {
        executeInMainThread {
            self.addSubviews()
            self.applySubviewsLayout()
            self.configureSubviews()
            self.renderChildComponents()
        }
    }
    
    func addSubviews() {
        for renderable in _renderables {
            view.addSubview(renderable.attachableView)
        }
    }
    
    func configureSubviews() {
        for renderable in _renderables {
            renderable.configureView()
        }
    }
    
    func renderChildComponents() {
        for renderable in self._renderables {
            renderable.render()
        }
    }
    
    func executeInMainThread(function: () -> ()) {
        if NSThread.currentThread().isMainThread {
            function()
        } else {
            dispatch_async(dispatch_get_main_queue(), function)
        }
    }
    
}
