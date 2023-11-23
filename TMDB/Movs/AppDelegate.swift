import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        setupWindow()
        setupObservers()
        return true
    }
    
    func setupAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorPalette.black]
        navigationBarAppearance.backgroundColor = ColorPalette.yellow
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = navigationBarAppearance
        }

        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = ColorPalette.yellow
        tabBarAppearance.tintColor = ColorPalette.black
        tabBarAppearance.isTranslucent = true
        tabBarAppearance.shadowImage = UIImage()
        tabBarAppearance.backgroundColor = ColorPalette.yellow
        
        UISearchBar.appearance().backgroundColor = ColorPalette.yellow
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = ColorPalette.black
        
        let movieApi = MovieApi()
        
        let popularViewController = PopularViewController(movieApi: movieApi)
        popularViewController.tabBarItem = UITabBarItem(title: "Popular", image: #imageLiteral(resourceName: "list_icon"), tag: 0)
        let popularNavigationController = UINavigationController(rootViewController: popularViewController)
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), tag: 1)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        let rootViewController = RootViewController(popularNavigationController: popularNavigationController, favoritesNavigationController: favoritesNavigationController)
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(forName: .onMovieFavorited, object: nil, queue: nil) { (notification) in
            if let movie = notification.userInfo?["movie"] as? Movie {
                var cachedMovies = Movie.getCachedMovies()
                
                if let isFavorite = movie.isFavorite, isFavorite {
                    cachedMovies.append(movie)
                } else {
                    if let index = cachedMovies.index(where: { $0 == movie }) {
                        cachedMovies.remove(at: index)
                    }
                }
                Movie.saveCachedMovies(cachedMovies)
            }
        }
    }
}

