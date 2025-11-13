from flask import Flask, jsonify

app = Flask(__name__)


# Simple main route
@app.route("/")
def hello_world():
    return "Hello World from the CI/CD Pipeline!"


# Health check endpoint
@app.route("/health")
def health_check():
    # In a real app, you'd check database connections, external services, etc.
    return jsonify({"status": "ok", "service": "cicd-demo-app"}), 200


# Simple mock test route for unit testing stage
def add_two_numbers(a, b):
    return a + b


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
