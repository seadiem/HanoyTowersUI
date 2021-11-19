import SwiftUI
import Induction

public struct Canvas: View {
    public init() {}
    public var body: some View {
        HanoyTowers()
            .frame(minWidth: 20,
                   maxWidth: .infinity,
                   minHeight: 20,
                   maxHeight: .infinity,
                   alignment: .center)
            .background(Rectangle().fill(Color.brown))
            .onAppear {}
  
    }
}

struct HanoyTowers: View {
    @StateObject var model = RecursionResolve()
    var body: some View {
        HanoyHStack(model: model.model).onAppear {
            model.run()
        }
    }
}

struct HanoyHStack: View {
    let model: HorisontalStck<Block<[Cell]>>
    @Namespace var namespace
    var body: some View {
        HStack(alignment: .bottom, spacing: 1) {
            HanoyColumn(model: model[.leftStack], namespace: namespace)
            HanoyColumn(model: model[.middleStack], namespace: namespace)
            HanoyColumn(model: model[.rightStack], namespace: namespace)
        }
        .animation(.easeIn.speed(4), value: model)
    }
}

struct HanoyColumn: View {
    
    let model: VerticalStack<Block<[Cell]>>
    let namespace: Namespace.ID
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 5).fill(Color.orange.opacity(0.1)).frame(width: 230, height: 240)
                VStack(alignment: .center, spacing: 1) {
                    ForEach(model.rows.reversed()) { block in
                        HanoyRow(model: block).matchedGeometryEffect(id: block.id, in: namespace)
                    }
                }
            }
            RoundedRectangle(cornerRadius: 5).fill(Color.black.opacity(0.1)).frame(width: 230, height: 50)
        }
    }
}

struct HanoyRow: View {
    let model: Block<[Cell]>
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.white.opacity(0.5))
            .frame(width: CGFloat(model.width), height: CGFloat(model.height), alignment: .center)
    }
}
