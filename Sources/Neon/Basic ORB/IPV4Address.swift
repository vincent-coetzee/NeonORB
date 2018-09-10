//
//  IPV4Address.swift
//  Apollo
//
//  Created by Vincent Coetzee on 2018/07/24.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public struct IPV4Address
    {
    let bytes:[UInt8]
    
    public var string:String
        {
        return("\(bytes[0]).\(bytes[1]).\(bytes[2]).\(bytes[3])")
        }
    
    public var intValue:UInt32
        {
        return(UInt32(bytes[3])<<24 + UInt32(bytes[2])<<16 + UInt32(bytes[1])<<8 + UInt32(bytes[0]))
        }
    
    public static func ethernetAddresses() -> [(IPV4Address,IPV4Address)]
        {
        var addresses : [(IPV4Address,IPV4Address)] = []
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else
            {
            return(addresses)
            }
        guard let firstAddr = ifaddr else
            {
            return(addresses)
            }
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next })
            {
            let interface = ifptr.pointee
            
            // Check for IPv4
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET)
                {
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name.hasPrefix("en")
                    {
                    // Convert interface address to a human readable string:
                    var addr = interface.ifa_addr.pointee
                    var address:IPV4Address = IPV4Address(0)
                    interface.ifa_addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1)
                        {
                        pointer in
                        address = IPV4Address(pointer.pointee.sin_addr.s_addr)
                        }
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),&hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST)
                    var netMask:IPV4Address = IPV4Address(0)
                    ifptr.pointee.ifa_netmask.withMemoryRebound(to: sockaddr_in.self, capacity: 1)
                        {
                        pointer in
                        netMask = IPV4Address(pointer.pointee.sin_addr.s_addr)
                        }
                    addresses.append((address,netMask))
                }
            }
        }
        freeifaddrs(ifaddr)
        return(addresses)
        }
    
    public func broadcastAddress(withNetmask mask:IPV4Address) -> IPV4Address
        {
        let value = self.intValue
        let bits = mask.intValue ^ 0xffffffff
        let address = value | bits
        return(IPV4Address(address))
        }
    
    init(_ value:UInt32)
        {
        bytes = [UInt8(value&255),UInt8((value & (255 << 8))>>8),UInt8((value & (255 << 16))>>16),UInt8((value & (255 << 24))>>24)]
        }
    }
