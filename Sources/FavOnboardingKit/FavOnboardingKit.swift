import UIKit

public protocol FavOnboardingKitDelegate: AnyObject {
    func nextButtonTap(atIndex: Int)
    func getStartedTap()
}

public final class FavOnboardingKit {
    private let themeFont: UIFont
    private let slides: [Slide]
    private let tintColor: UIColor
    private var rootCV: UIViewController?
    
    public weak var delegate: FavOnboardingKitDelegate?
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let controller = OnboardingViewController(
            slides: slides,
            tintColor: tintColor, themeFont: themeFont)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.nextButtonDidTap = { [weak self] index in
            self?.delegate?.nextButtonTap(atIndex: index)
        }
        controller.getStartedButtonTap = { [weak self] in
            self?.delegate?.getStartedTap()
        }
        return controller
    }()
    
    public init(slides: [Slide],
                tintColor: UIColor,
                themeFont: UIFont = UIFont(name: "ArialRoundedMTBold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
    }
    
    public func launchOnboarding(rootVC: UIViewController) {
        self.rootCV = rootVC
        rootVC.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding() {
        onboardingViewController.stopAnimation()
        if rootCV?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true)
        }
    }
}
