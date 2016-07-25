//
//  GCDBlackBox.swift
//  NetworkRequest
//
//  Created by Konstantin Gerov on 7/25/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}
