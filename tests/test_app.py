import pytest
from app.app import app

@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

def test_home_page(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"Stock Quote App" in response.data

def test_stock_lookup(client):
    response = client.post("/", data={"symbol": "AAPL"})
    assert response.status_code == 200
    assert b"AAPL" in response.data
