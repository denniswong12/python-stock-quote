from flask import Flask, render_template, request
import yfinance as yf

app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def index():
    stock_data = None
    error = None

    if request.method == "POST":
        symbol = request.form.get("symbol", "").upper().strip()
        if symbol:
            try:
                stock = yf.Ticker(symbol)
                stock_data = {
                    "symbol": symbol,
                    "name": stock.info.get("longName", "N/A"),
                    "price": stock.info.get("regularMarketPrice", "N/A"),
                    "currency": stock.info.get("currency", "N/A"),
                    "previous_close": stock.info.get("regularMarketPreviousClose", "N/A")
                }
            except Exception as e:
                error = f"Error fetching data: {e}"

    return render_template("index.html", stock_data=stock_data, error=error)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000,debug=False)
