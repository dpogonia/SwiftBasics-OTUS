import Foundation

class RoundedHole {
    let radius: Double
    
    init(holeRadius: Double) {
        radius = holeRadius
    }
    
    func fitsPeg(peg: RoundedPeg) -> Bool {
        radius >= peg.radius
    }
}

class RoundedPeg {
    let radius: Double
    
    init(pegRadius: Double) {
        radius = pegRadius
    }
}


class SquarePeg {
    let side: Double
    
    init(pegSide: Double) {
        side = pegSide
    }
}


class SquareAdapter: RoundedPeg {
    private let squarePeg: SquarePeg
    
    init(oldPeg: SquarePeg) {
        squarePeg = oldPeg
        super.init(pegRadius: oldPeg.side * sqrt(2.0) / 2.0)
        
    }
}


let hole = RoundedHole(holeRadius: 5.0)
let rPeg = RoundedPeg(pegRadius: 5.0)



let smallPeg = SquarePeg(pegSide: 5.0)
let medPeg = SquarePeg(pegSide: 10.0)


//errror
//hole.fitsPeg(peg: smallPeg)

let smalAdapter = SquareAdapter(oldPeg: smallPeg)
let medAdapter = SquareAdapter(oldPeg: medPeg)

print(hole.fitsPeg(peg: smalAdapter))
print(hole.fitsPeg(peg: medAdapter))
