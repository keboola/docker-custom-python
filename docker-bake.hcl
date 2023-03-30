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

target "python-311" {
  context = "./python-3.11/"
  tags = ["keboola/docker-custom-python:python-3.11"]
}

target "python-snowpark" {
  context = "./python-snowpark/"
  tags = ["keboola/docker-custom-python-snowpark"]
  contexts = {
    python = "target:python-38"
  }
}
