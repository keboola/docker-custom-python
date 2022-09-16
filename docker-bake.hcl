group "default" {
  targets = [
    "python-38",
    "python-310"
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
