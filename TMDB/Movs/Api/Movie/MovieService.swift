import Foundation

protocol MovieService: Service {
    func getPopularMovies(page: Int, completion: @escaping Response<PopularMoviesResponse>)
    func getGenres(completion: @escaping Response<[Genre]>)
}
