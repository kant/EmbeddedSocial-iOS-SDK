//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

class TopicCommand: OutgoingCommand {
    private(set) var topic: Post
    
    required init?(json: [String: Any]) {
        guard let topicJSON = json["topic"] as? [String: Any],
            let topic = Post(json: topicJSON) else {
                return nil
        }
        
        self.topic = topic
        
        super.init(json: json)
    }
    
    required init(topic: Post) {
        self.topic = topic
        super.init(json: [:])!
    }
    
    func setImageHandle(_ imageHandle: String?) {
        topic.imageHandle = imageHandle
    }
    
    func apply(to topic: inout Post) {
        
    }
    
    override func encodeToJSON() -> Any {
        return [
            "topic": topic.encodeToJSON(),
            "type": typeIdentifier
        ]
    }
    
    override func getHandle() -> String? {
        return topic.topicHandle
    }
    
    override func getRelatedHandle() -> String? {
        return topic.topicHandle
    }
    
    override func setRelatedHandle(_ relatedHandle: String?) {
        topic.topicHandle = relatedHandle
    }
}