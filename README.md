# Task in Docker
```bash
docker build -t task .
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) task --help
```