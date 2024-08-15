//
//  NetworkConnectionManager.swift
//  InstaSport
//
//  Created by Youssif Hany on 14/08/2024.
//

import Foundation
import Network

final class NetworkConnectionManager{
    static let shared = NetworkConnectionManager()
    
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    
    
    public private(set) var isConnected : Bool = false // Public to read but private to write
    
    public private(set) var connectionType : ConnectionType = .unknown // Public to read but private to write
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path:NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }else {
            connectionType = .unknown
        }
    }
    
    enum ConnectionType{
        case wifi
        case cellular
        case ethernet
        case unknown
    }
}
