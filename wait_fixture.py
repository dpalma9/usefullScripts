@pytest.fixture(scope="module")
def disconnect_component(pytestconfig):
    capmanager = pytestconfig.pluginmanager.getplugin('capturemanager')

    capmanager.suspend_global_capture(in_=True)
    input('Disconnect the component, then press enter')
    capmanager.resume_global_capture()

    yield

    capmanager.suspend_global_capture(in_=True)
    input('Conect the component again, then press enter')
    capmanager.resume_global_capture()
