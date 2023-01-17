enum EProcessStatus {
  /// Initial status
  init,

  /// Resize image to 1200x800
  resizing,

  /// After choosed from lib or camera
  waitingServer,

  /// After received mask from server
  colorMapping,

  /// Done
  done,

  ///Error,
  error,
}
