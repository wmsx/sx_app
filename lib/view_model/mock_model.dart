class MockModel {
  bool _mock = true;
  set mock(bool mock) {
    _mock = mock;
  }

  bool get isMock => _mock;
}
