class CacheService {
  final Map<String, dynamic> _cacheData = {};
  final int cacheDurationInHours;

  CacheService(this.cacheDurationInHours);

  void setData<T>(String key, T data) {
    final DateTime now = DateTime.now();
    final DateTime expiryTime = now.add(Duration(hours: cacheDurationInHours));
    _cacheData[key] = {
      'data': data,
      'expiryTime': expiryTime,
    };
  }

  T? getData<T>(String key) {
    dynamic cachedData = _cacheData[key];
    if (cachedData != null && cachedData is Map<String, dynamic>) {
      final DateTime now = DateTime.now();
      final DateTime expiryTime = cachedData['expiryTime'] as DateTime;

      if (now.isBefore(expiryTime)) {
        return cachedData['data'] as T?;
      } else {
        _cacheData.remove(key);
      }
    }
    return null;
  }
}
