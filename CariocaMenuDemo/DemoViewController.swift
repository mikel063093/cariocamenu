//
//  ViewController.swift
//  CariocaMenuDemo
//

import UIKit

class DemoViewController: UIViewController {
    var carioca: CariocaMenu?
	@IBOutlet weak var iconView: CariocaIconView!
	@IBOutlet weak var gradientView: ASGradientView!

	override func viewDidLoad() {
		setupGradient()
	}

    override func viewDidAppear(_ animated: Bool) {
		iconView.label.font = UIFont.boldSystemFont(ofSize: 75)
		iconView.display(icon: CariocaIcon.emoji("🤙🏼"))
        initialiseCarioca()
    }

    func initialiseCarioca() {
        if var menuController = self.storyboard?.instantiateViewController(withIdentifier: "DemoMenu")
            as? CariocaController {
			addChildViewController(menuController)
			menuController.menuItems = [
				CariocaMenuItem("Hello", .emoji("🤙🏼")),
				CariocaMenuItem("About", .icon(UIImage(named: "hamburger")!)),
				CariocaMenuItem("Settings", .emoji("🛠")),
				CariocaMenuItem("Brasil", .emoji("🇧🇷")),
				CariocaMenuItem("ZZZ", .emoji("Z"))
			]
			carioca = CariocaMenu(controller: menuController,
								  hostView: self.view,
								  edges: [.right, .left],
//								  edges: [.left, .right],
//								  edges: [.left],
								  delegate: self,
								  indicator: CariocaCustomIndicatorView()
								  )
			carioca?.addInHostView()
        }
    }
	// MARK: Rotation management
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animateAlongsideTransition(in: self.view, animation: nil, completion: { [weak self] _ in
			self?.carioca?.hostViewDidRotate()
		})
	}
	// MARK: Gradient setup
	func setupGradient() {
		gradientView.colors = [
			//turquoise, green sear
			(start: UIColor(red: 0.17, green: 0.73, blue: 0.61, alpha: 1.00),
			 end: UIColor(red: 0.14, green: 0.62, blue: 0.52, alpha: 1.00)),
			//emerald, nephritis
			(start: UIColor(red: 0.23, green: 0.79, blue: 0.45, alpha: 1.00),
			 end: UIColor(red: 0.20, green: 0.67, blue: 0.39, alpha: 1.00)),
			//amethyst, wisteria
			(start: UIColor(red: 0.60, green: 0.36, blue: 0.71, alpha: 1.00),
			 end: UIColor(red: 0.55, green: 0.29, blue: 0.67, alpha: 1.00)),
			//sunflower, orange
			(start: UIColor(red: 0.95, green: 0.61, blue: 0.17, alpha: 1.00),
			 end: UIColor(red: 0.95, green: 0.61, blue: 0.17, alpha: 1.00))
		]

		gradientView.animateGradient()
	}
}

extension DemoViewController: CariocaDelegate {
	func cariocamenu(_ menu: CariocaMenu, didSelect item: CariocaMenuItem, at index: Int) {
        CariocaMenu.log("didSelect \(item) at \(index)")
		iconView.display(icon: item.icon)
    }

    func cariocamenu(_ menu: CariocaMenu, willOpenFromEdge edge: UIRectEdge) {
        CariocaMenu.log("will open from \(edge)")
    }
}

class CariocaCustomIndicatorView: UIView, CariocaIndicatorConfiguration {

	public func iconMargins(for edge: UIRectEdge) -> (top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
//		if edge == .left {
			return (top: 0.0, right: 0.0, bottom: 0.0, left: 0.0)
//		} else {}
	}

	var size: CGSize = CGSize(width: 50, height: 50)

	func shape(for edge: UIRectEdge, frame: CGRect) -> UIBezierPath {
		let polygonPath = UIBezierPath()
		polygonPath.move(to: CGPoint(x: frame.minX + 0.50500 * frame.width, y: frame.minY + 0.01000 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.79595 * frame.width, y: frame.minY + 0.10454 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.97577 * frame.width, y: frame.minY + 0.35204 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.97577 * frame.width, y: frame.minY + 0.65796 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.79595 * frame.width, y: frame.minY + 0.90546 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.50500 * frame.width, y: frame.minY + 1.00000 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.21405 * frame.width, y: frame.minY + 0.90546 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.03423 * frame.width, y: frame.minY + 0.65796 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.03423 * frame.width, y: frame.minY + 0.35204 * frame.height))
		polygonPath.addLine(to: CGPoint(x: frame.minX + 0.21405 * frame.width, y: frame.minY + 0.10454 * frame.height))
		polygonPath.close()
		UIColor(red:  0.63, green:  0.76, blue:  0.22, alpha:  1.00).setFill()
		polygonPath.fill()
		return polygonPath
	}
}
