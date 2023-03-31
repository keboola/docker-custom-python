group "default" {
  targets = [
    "python38",
    "python310",
    "pythonSnowpark"
  ]
}

target "python38" {
  context = "./python-3.8/"
  tags = ["keboola/docker-custom-python:python-3.8"]
}

target "python310" {
  context = "./python-3.10/"
  tags = ["keboola/docker-custom-python:python-3.10"]
}

target "pythonSnowpark" {
  context = "./python-snowpark/"
  tags = ["keboola/docker-custom-python-snowpark"]
  contexts = {
    python = "target:python-38"
  }
}
