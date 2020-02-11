from flask import Flask, escape, request
import json
import os
import joblib
import pandas as pd
import numpy as np

app = Flask(__name__)

# Read location of model file
config_file = "server/model_location_config.json"
with open(config_file, "r") as f:
    model_location = json.load(f)
output_folder = model_location["output_folder"]
model_file = model_location["model_file"]

# Read the pipeline
target_file = os.path.join("server/static", model_file)
pipeline = joblib.load(target_file)


@app.route('/')
def hello():
    name = request.args.get("name", "World")
    return f'Hello, {escape(name)}! This is deployed on travis.'


# Make an endpoint that accepts one variable `data` as input
@app.route('/predict/<string:data>')
def predict(data: str):
    converted_data = pd.read_json(data)
    return str(pipeline.transform(converted_data))


example_df = pd.read_csv("server/static/iris.csv")
example_df = example_df[example_df["Species"].isin(["setosa", "virginica"])]


# Make an endpoint to test random inputs
@app.route('/predict_test/<int:n>')
def predict_test(n: int = 5):
    sample_indices = np.random.randint(low=0, high=example_df.shape[0], size=n)
    subset = example_df.iloc[sample_indices]
    predictions = pipeline.transform(subset.drop("Species", axis=1))

    result = pd.DataFrame({
        "predictions": predictions,
        "actual": subset["Species"]
    })

    return result.to_html()
