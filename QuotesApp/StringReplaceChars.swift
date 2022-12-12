//
//  StringReplaceChars.swift
//  QuotesIOSApp
//

import Foundation

/*
    This function extends the native string class.
    - toBeReplaced is the char that is going to be replaced
    - replacingWith is the char that the prev char will be replaced with
    Returns the original string if it does not contain the char toBeReplaced
    Returns new string with the char replaced
*/
extension String {
    func replaceWith(toBeReplaced: Character, replacingWith: Character)-> String {
        if(!self.contains(toBeReplaced)){
            return self
        }
        var str = self
        while(self.contains(toBeReplaced)){
            //The guard shortcuits if firstIndex is nil meaning character isn't inside
            guard let upTo = str.firstIndex(of: toBeReplaced) else { return str }
            let firstHalf = str.prefix(upTo: upTo)
            //str.index(after: upTo) -> b/c u can't +1 to the index
            let secondHalf = str.suffix(from: str.index(after: upTo))
            str = String(firstHalf)+String(replacingWith)+String(secondHalf)
            //print(firstHalf)
            //print(secondHalf)
        }
        return str
    }
}
    

