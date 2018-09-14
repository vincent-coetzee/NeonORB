import XCTest
@testable import Neon

final class NeonTests: XCTestCase
    {
    func testMarshalling()
        {
        let marshaller = IIOPMarshaller()
        marshaller.marshal(UInt8(5))
        marshaller.marshal(12)
        marshaller.marshal("Hello world")
        marshaller.marshal(47)
        marshaller.marshal(["These","are","strings"])
        marshaller.marshal(20346)
        marshaller.marshal([UInt8(9),UInt8(7),UInt8(5),UInt8(3)])
        marshaller.marshal(["Some","more","strings"])
        marshaller.marshal(65536)
        let bytes = marshaller.bytes
        let unmarshaller = IIOPUnmarshaller(bytes:bytes)
        _ = unmarshaller.unmarshal(Int.self)
        XCTAssertEqual(unmarshaller.unmarshal(UInt8.self),UInt8(5))
        XCTAssertEqual(unmarshaller.unmarshal(Int.self),12)
        XCTAssertEqual(unmarshaller.unmarshal(String.self),"Hello world")
        XCTAssertEqual(unmarshaller.unmarshal(Int.self),47)
        XCTAssertEqual(unmarshaller.unmarshal(Array<String>.self),["These","are","strings"])
        XCTAssertEqual(unmarshaller.unmarshal(Int.self),20346)
        XCTAssertEqual(unmarshaller.unmarshal(Array<UInt8>.self),[UInt8(9),UInt8(7),UInt8(5),UInt8(3)])
        XCTAssertEqual(unmarshaller.unmarshal(Array<String>.self),["Some","more","strings"])
        XCTAssertEqual(unmarshaller.unmarshal(Int.self),65536)
        }

    static var allTests = [
        ("testMarshalling", testMarshalling),
    ]
}
