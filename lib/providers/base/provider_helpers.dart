///remains same
enum ProviderState {
  none,
  loading,
  noInternet,
  success,
  failed,
  noData,
}

///can be changed acc. to requirements
enum ProviderEvent {
  none,
  generateCode,
  generateAccessToken,
  fetchLatestCollection,
  fetchPostDetail,
  searchProducts
}
