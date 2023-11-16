import Foundation
import Cache

class StorageUtils<T: Codable> {
    class func shared() -> Storage<String, T>? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true).appendingPathComponent("MyPreferences") else {
            return nil
        }
        let diskConfig = DiskConfig(
            name: "Floppy",
            expiry: .never,
            maxSize: 10000,
            directory: directory,
            protectionType: .complete
        )
        
        let memoryConfig = MemoryConfig(
            expiry: .date(Date().addingTimeInterval(2*60)),
            countLimit: 50,
            totalCostLimit: 0
        )

        let storage = try? Storage<String, T>(
          diskConfig: diskConfig,
          memoryConfig: memoryConfig,
          transformer: TransformerFactory.forCodable(ofType: T.self)
        )

        return storage
    }
}
