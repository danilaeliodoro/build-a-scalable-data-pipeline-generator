// Data Model for Scalable Data Pipeline Generator

import Foundation

// Define a protocol for data sources
protocol DataSource {
    associatedtype DataType
    func fetch() -> [DataType]
}

// Define a protocol for data processors
protocol DataProcessor {
    associatedtype InputType
    associatedtype OutputType
    func process(_ data: [InputType]) -> [OutputType]
}

// Define a protocol for data sinks
protocol DataSink {
    associatedtype DataType
    func write(_ data: [DataType])
}

// Define a data pipeline model
struct DataPipeline {
    let dataSource: DataSource
    let dataProcessors: [DataProcessor]
    let dataSink: DataSink
    
    init(dataSource: DataSource, dataProcessors: [DataProcessor], dataSink: DataSink) {
        self.dataSource = dataSource
        self.dataProcessors = dataProcessors
        self.dataSink = dataSink
    }
    
    func execute() {
        let inputData = dataSource.fetch()
        var processData = inputData
        for processor in dataProcessors {
            processData = processor.process(processData)
        }
        dataSink.write(processData)
    }
}

// Define a generator for data pipelines
struct DataPipelineGenerator {
    static func generatePipeline(dataSource: DataSource, dataProcessors: [DataProcessor], dataSink: DataSink) -> DataPipeline {
        return DataPipeline(dataSource: dataSource, dataProcessors: dataProcessors, dataSink: dataSink)
    }
}