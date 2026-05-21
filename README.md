# Docker Jenkins Pipeline

A CI/CD project that automates building, tagging, pushing, and running a Python Docker image using Jenkins Declarative Pipeline.

---

## Project Structure

```
docker-jenkins-pipeline/
├── Dockerfile        # Defines the Docker image for the Python app
├── helloworld.py     # Simple Python application
├── Jenkinsfile       # Jenkins Declarative Pipeline definition
├── LICENSE
└── README.md
```

---

## Application

**`helloworld.py`** — A minimal Python script:

```python
print("hello world")
```

---

## Docker

**`Dockerfile`** — Builds a lightweight Python 3.10 image:

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY helloworld.py .
CMD ["python", "helloworld.py"]
```

### Build & Run Locally

```bash
# Build the image
docker build -t atuljkamble/helloworldpython:latest .

# Run the container
docker run atuljkamble/helloworldpython:latest
```

---

## Jenkins CI/CD Pipeline

**`Jenkinsfile`** — Declarative pipeline with 3 stages:

```
Pipeline
├── Stage 1: Docker Build   — builds image tagged with BUILD_NUMBER and latest
├── Stage 2: Docker Push    — authenticates to DockerHub and pushes both tags
└── Stage 3: Container Run  — runs the versioned container
```

### Pipeline Stages

| Stage | Description |
|---|---|
| **Docker Build** | Builds the image with two tags: `:<BUILD_NUMBER>` and `:latest` |
| **Docker Push** | Logs in to DockerHub using `dockerhub-creds` and pushes both tags |
| **Container Run** | Runs the container using the build-specific tag |

### Post Actions

| Result | Action |
|---|---|
| **Success** | Prints `Docker image built and pushed successfully!` |
| **Failure** | Prints `Docker build or push failed.` |

---

## Prerequisites

- **Jenkins** with the following plugins installed:
  - Pipeline
  - Docker Pipeline
  - Credentials Binding
- **Docker** installed and accessible on the Jenkins agent
- **DockerHub account** — image is published to `atuljkamble/helloworldpython`

---

## Jenkins Credentials Setup

Add DockerHub credentials in Jenkins before running the pipeline:

1. Go to **Manage Jenkins → Credentials → (global) → Add Credentials**
2. Kind: **Username with password**
3. Username: your DockerHub username
4. Password: your DockerHub password or access token
5. ID: `dockerhub-creds`

---

## Image Versioning

Each successful build produces two Docker image tags:

| Tag | Description |
|---|---|
| `atuljkamble/helloworldpython:<BUILD_NUMBER>` | Immutable, build-specific tag |
| `atuljkamble/helloworldpython:latest` | Always points to the most recent build |

---

## DockerHub

Image: [https://hub.docker.com/r/atuljkamble/helloworldpython](https://hub.docker.com/r/atuljkamble/helloworldpython)

```bash
docker pull atuljkamble/helloworldpython:latest
```

---

## Author

**Atul Kamble** — [github.com/atulkamble](https://github.com/atulkamble)