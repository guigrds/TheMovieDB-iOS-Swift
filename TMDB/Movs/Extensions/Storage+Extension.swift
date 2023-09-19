import Foundation
import Cache

extension Storage {
    class func shared() -> Storage? {
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
        
        let dataTransformer = Transformer<Value>(
            toData: { value in
                // Transformar o valor (Data) em Data
                return value as! Data
            },
            fromData: { data in
                // Transformar Data de volta para o valor original (Data)
                return data as! Value
            }
        )
        return try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: dataTransformer)
    }
}
