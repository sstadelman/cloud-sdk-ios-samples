//
//  ObservingView.swift
//  ObservationMemoryLeak
//
//  Created by Takahashi, Alex on 12/17/18.
//  Copyright © 2018 Takahashi, Alex. All rights reserved.
//

import Foundation
import UIKit

class LeakingObservingView: UIView {
    
    // FIXME: Change the boolean to change the observation
    private var isLeakingObservation = true
    
    internal var observation: NSKeyValueObservation!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func setup() {
        self.backgroundColor = isLeakingObservation ? .red : .green
        
        if isLeakingObservation {
            observation = self.observe(\.layer.bounds) { (observed, _) in
                print("💧 Leaking Observation!")
            }
        } else {
            observation = self.layer.observe(\.bounds) { (observed, _) in
                print("✅ Safe Observation")
            }
        }
    }
}
