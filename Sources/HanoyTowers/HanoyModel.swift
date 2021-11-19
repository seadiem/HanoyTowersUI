import Induction

enum Cell: EmptyInit, Equatable {
    case empty
    case full(Brick)
    var isEmpty: Bool { self == .empty }
    init() {
        self = .empty
    }
}

struct Brick: Equatable {
    static var brick: Brick { Brick() }
    let diagonal: SIMD2<Float>
    init() {
        diagonal = [20, 20]
    }
}

extension Block: Identifiable {}

extension Block where Element == Cell {
    var bricks: [Brick] {
        var bricks = [Brick]()
        sandbox.forEach { cell in
            switch cell {
            case .full(let brick): bricks.append(brick)
            default: break
            }
        }
        return bricks
    }
    var width: Float {
        bricks.reduce(0) { $0 + $1.diagonal.x }
    }
    var height: Float {
        bricks.max { $0.diagonal.y > $1.diagonal.y }?.diagonal.y ?? 0 // Danger(!)
    }
}

extension HorisontalStck: Equatable {
    public static func == (lhs: HorisontalStck<Element>, rhs: HorisontalStck<Element>) -> Bool { false }
}

struct HanoyStacksMaker {
    var vstack: VerticalStack<Block<[Cell]>> {
        var v = VerticalStack<Block<[Cell]>>()
        try! v.push(element: Block(box: [Cell.full(.brick), .full(.brick), .full(.brick), .full(.brick), .full(.brick)], id: 2))
        try! v.push(element: Block(box: [Cell.full(.brick), .full(.brick), .full(.brick), .full(.brick)], id: 1))
        try! v.push(element: Block(box: [Cell.full(.brick), .full(.brick), .full(.brick)], id: 0))
        return v
    }
    var hstack: HorisontalStck<Block<[Cell]>> {
        var h = HorisontalStck<Block<[Cell]>>()
        let v = VerticalStack<Block<[Cell]>>()
        
        h.push(column: v)
        h.push(column: v)
        h.push(column: v)
        
    
        (1...10).reversed().forEach { n in
            let row = Array(repeating: Cell.full(.brick), count: n)
            let block = Block(box: row, id: n)
            h.push(block: block, to: .leftStack)
        }
        return h
    }
}

