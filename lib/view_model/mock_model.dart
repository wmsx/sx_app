class MockModel {
  bool _mock = false;
  set mock(bool mock) {
    _mock = mock;
  }

  bool get isMock => _mock;
}
