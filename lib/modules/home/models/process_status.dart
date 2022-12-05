enum EProcessStatus {
  /// Initial status
  init,

  /// After choosed from lib or camera
  waitingServer,

  /// After received mask from server
  colorMapping,

  /// Done
  done,

  ///Error,
  error,
}
