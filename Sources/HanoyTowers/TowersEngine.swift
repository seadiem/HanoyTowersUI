import Induction
import Combine
import CoreFoundation


actor RecursionResolve: ObservableObject {
    
    @Published @MainActor var model: HorisontalStck<Block<[Cell]>> = HanoyStacksMaker().hstack
    
    @MainActor func tap() {
        var work = model
        let block = work.popBlock(from: .leftStack)!
        work.push(block: block, to: .rightStack)
        set(model: work)
    }
    
    
    @MainActor func run() {
        Task.detached {
            for (index, _) in (0...3).enumerated() {
                print(3 - index)
                await Task.sleep(1_000_000_000)
            }
            print("run")
            let work = await self.model
            let out = await self.move(from: .leftStack, to: .middleStack, howMuchBlocks: 10, stack: work)
            await self.set(model: out)
        }
    }
    
    @MainActor func set(model: HorisontalStck<Block<[Cell]>>) {
        self.model = model
    }
    
    let time: UInt64 = 40_000_000
    
    func move(from a: StackPosition,
              to b: StackPosition,
              howMuchBlocks: Int,
              stack: HorisontalStck<Block<[Cell]>>) async -> HorisontalStck<Block<[Cell]>> {
        
 
        
        
        if howMuchBlocks == 1 {
            var h = stack
            let block = h.popBlock(from: a)!
            h.push(block: block, to: b)
            await Task.sleep(time)
            await set(model: h)
            return h
        } else {
            let k = StackPosition.getReminder(a: a, b: b)
            var h1 = await move(from: a, to: k, howMuchBlocks: howMuchBlocks - 1, stack: stack)
            let block = h1.popBlock(from: a)!
            h1.push(block: block, to: b)
            await Task.sleep(time)
            await set(model: h1)
            
            
            h1 = await move(from: k, to: b, howMuchBlocks: howMuchBlocks - 1, stack: h1)
            await Task.sleep(time)
            await set(model: h1)
            
            return h1
        }
    }
}
