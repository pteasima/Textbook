import UIKit
func id<A>(_ a: A) -> A { return a }

private let infinity = 4


final class CollectionViewCell: UICollectionViewCell {
    var content: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let content = content {
                contentView.addSubview(content, constraints: .fillParent())
        }
            
        }
    }
}

var reals: [Double?] = .init(repeating: nil, count: infinity)
final class DataSource: UICollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infinity
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let simpleCell: Rendering<String, CollectionViewCell> = simpleLabel.map {
            //TODO: weak?
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.content = $0
            
            return cell 
        }
        let number: Rendering<Int, CollectionViewCell> = simpleCell.pullback(String.init(describing:))
        
        let wholeNumber: Rendering<Int, CollectionViewCell> = number.pullback {
            guard $0 != 0 else { return 0 }
            let index = $0 + 1
            let sign = index % 2 == 0 ? -1 : 1
            let half = (index / 2)
            return half * sign
        }
        let realNumber: Rendering<Int, CollectionViewCell> = simpleCell.pullback { index in
         String(format: "%.\(infinity)f", reals[index] ?? {
         reals[index] = Double.random(in: 0..<1)
         return reals[index]!
         }())
         }
        
        switch indexPath.section {
        case 0:         
            return number.render(indexPath.item)
        case 1:
            return wholeNumber.render(indexPath.item)
        default: return realNumber.render(indexPath.item)
        }
        
    }
}


public final class ViewController: UICollectionViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    
    
}
let dataSource = DataSource()
var isNaturalsHidden = false
var isWholesHidden = true


public let collectionVC: Rendering<Void, ViewController> = .init { 
    final class Layout: UICollectionViewLayout {
        let itemSize = 100
        override var collectionViewContentSize: CGSize { return .init(width:500 , height: collectionView!.numberOfItems(inSection: 0)*itemSize) }
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let firstRow = Int(rect.origin.y) / itemSize
            let lastRow = Int(rect.origin.y + rect.height) / itemSize
            
            return Array(0..<collectionView!.numberOfSections).flatMap { s in
            Array(firstRow..<min(lastRow, collectionView!.numberOfItems(inSection: s))).map { IndexPath(item: $0, section: s) }
            }.map { layoutAttributesForItem(at: $0)!}
        }
        override func layoutAttributesForItem(at indexPath: IndexPath) ->UICollectionViewLayoutAttributes? {
            return with(UICollectionViewLayoutAttributes(forCellWith: indexPath), mut(\.frame, CGRect(origin: CGPoint(x: indexPath.section*itemSize, y: indexPath.item*itemSize), size: CGSize(width: itemSize, height: itemSize))))
        }
        
    }
    //omg because of a Playgrounds bug I cant make a datasource unless I inherit from controller
    return with(ViewController(collectionViewLayout: Layout()), mut(\.collectionView.dataSource, dataSource))
}
import PlaygroundSupport
/*environment.setLiveView = {
    let window = UIWindow(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
    window.rootViewController = $0 as! UIViewController
    PlaygroundPage.current.liveView = window
}*/
//PlaygroundPage.current.wantsFullScreenLiveView = true



//environment.ask("wut wut?", ["in the butt"]) {
//$0
//}

// The End🙈
_delimiter = "🙈"
environment.savePage("Reals.swift")

environment.setLiveView(collectionVC.render(()))
