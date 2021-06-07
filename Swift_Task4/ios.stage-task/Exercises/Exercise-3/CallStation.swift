import Foundation

final class CallStation {
    var usersArray = [User]()
    var callsArray  = [Call]()
    
}

extension CallStation: Station {
    
    func users() -> [User] {
        return usersArray
    }
    
    func add(user: User) {
        if !(usersArray.contains(user)) {
            usersArray.append(user)
        }
    }
    
    func remove(user: User) {
        if let itemToRemoveIndex = usersArray.firstIndex(of: user) {
            usersArray.remove(at: itemToRemoveIndex)
        }
    }
    
    func execute( action: CallAction) -> CallID? {
        let clients = action.get
        switch action {
        case .start:
            let id = UUID()
            
            if !users().contains(clients()[0]) {
                return nil
            }
            
            if !users().contains(clients()[1]) {
                let call = Call(id: id, incomingUser: clients()[1], outgoingUser: clients()[0], status: CallStatus.ended(reason: CallEndReason.error) )
                callsArray.append(call)
                return id
            }
            
            if let _ = currentCall(user:clients()[1]) {
                let call = Call(id: id, incomingUser: clients()[1], outgoingUser: clients()[0], status: CallStatus.ended(reason: CallEndReason.userBusy) )
                callsArray.append(call)
                return id
            }else{
                let call = Call(id: id, incomingUser: clients()[1], outgoingUser: clients()[0], status: CallStatus.calling )
                callsArray.append(call)
                return id

            }

        case .answer:
            let callIndex = callsArray.firstIndex(where: {$0.incomingUser.id == clients()[0].id && $0.status == CallStatus.calling})
            
            if !users().contains(clients()[0]) {
                if let callIndexNew = callIndex {
                    let call = callsArray[callIndexNew]
                    let updatedCall = Call(id: call.id, incomingUser: call.incomingUser,  outgoingUser: call.outgoingUser, status: CallStatus.ended(reason: CallEndReason.error))
                    callsArray[callIndexNew] = updatedCall
                }
                return nil
            }
            
            
            if let callIndexNew = callIndex {
                let call = callsArray[callIndexNew]
                let updatedCall = Call(id: call.id, incomingUser: call.incomingUser,  outgoingUser: call.outgoingUser, status: CallStatus.talk)
                callsArray[callIndexNew] = updatedCall
                return updatedCall.id
            }
            return nil
        
        case .end:
            let callIndex = callsArray.firstIndex(where: {
                                                   ( $0.outgoingUser.id == clients()[0].id || $0.incomingUser.id == clients()[0].id) && ($0.status == CallStatus.talk || $0.status == CallStatus.calling )  })
            if let callIndexNew = callIndex {
                let call = callsArray[callIndexNew]
                var reason: CallEndReason
                if(call.status == CallStatus.calling){
                    reason = CallEndReason.cancel
                }else {
                    reason = CallEndReason.end
                }
                let updatedCall = Call(id: call.id, incomingUser: call.incomingUser,  outgoingUser: call.outgoingUser, status: CallStatus.ended(reason: reason))
                callsArray[callIndexNew] = updatedCall
                return updatedCall.id
            }
            return nil
        }
    }
    
    func calls() -> [Call] {
       return  callsArray
    }
    
    func calls(user: User) -> [Call] {
        return callsArray.filter{$0.incomingUser.id == user.id || $0.outgoingUser.id == user.id}
    }
    
    func call(id: CallID) -> Call? {
        let a = callsArray.filter{$0.id == id}
        if(a.count == 0){
            let call : Call? = nil
            return call
        }
        return a[0]
    }
    
    func currentCall(user: User) -> Call? {
        let a = callsArray.filter{($0.incomingUser.id == user.id || $0.outgoingUser.id == user.id) && ($0.status == CallStatus.calling  || $0.status == CallStatus.talk) }
        if(a.count == 0){
            let call : Call? = nil
            return call
        }
        return a[0]
    }
}
