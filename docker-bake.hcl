group "default" {
  targets = [
    "python-38",
    "python-310",
    "python-snowpark"
  ]
}

target "python-38" {
  context = "./python-3.8/"
  tags = ["keboola/docker-custom-python:python-3.8"]
}

target "python-310" {
  context = "./python-3.10/"
  tags = ["keboola/docker-custom-python:python-3.10"]
}

target "python-snowpark" {
  context = "./python-snowpark/"
  tags = ["keboola/docker-custom-python-snowpark:python-3.8"]
  contexts = {
    python-38 = "target:python-38"
  }
}
