//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

class BlockCommand: UserCommand {
    override var oppositeCommand: UserCommand? {
        return UnblockCommand(user: user)
    }
}
