# Kubernetes Lab: Hello World Application

This directory contains everything you need for the **Kubernetes Container Orchestration Lab**.

## Quick Start

### Option 1: Use the Sample Application (Recommended for Lab)

This repository includes a simple Node.js "Hello World" application that is perfect for learning Kubernetes.

#### Build the Docker Image

```bash
# Connect to Minikube's Docker daemon
eval $(minikube docker-env)

# Build the image
docker build -t microservice:v1 .

# Verify the image was created
docker images | grep microservice
```

#### Deploy to Kubernetes

```bash
# Apply the Deployment
kubectl apply -f deployment.yaml

# Apply the Service
kubectl apply -f service.yaml

# Verify it's running
kubectl get pods
kubectl get services
```

#### Access the Application

```bash
# Get the service URL
minikube service microservice-service --url

# Open in browser or test with curl
curl http://<returned-url>/
```

### Option 2: Use Your Own Spring Boot Application

If you have a Spring Boot microservice from previous labs:

1. Place your Spring Boot application in this directory
2. Ensure it has a `Dockerfile` in the root
3. Follow the same build steps above

## Application Details

### Sample Application (Node.js Express)

**Files:**
- `app.js` - Express.js application
- `package.json` - Node.js dependencies
- `Dockerfile` - Container configuration

**Endpoints:**
- `GET /` - Hello World HTML page with pod information
- `GET /health` - Health check (for Kubernetes liveness probes)
- `GET /ready` - Readiness check (for Kubernetes readiness probes)
- `GET /api/info` - JSON API endpoint with pod details

### Building the Image

```bash
docker build -t microservice:v1 .
```

### Running Locally (without Kubernetes)

```bash
# Install dependencies
npm install

# Run the app
npm start

# Visit http://localhost:8080
```

## Lab Instructions

Follow the **main.pdf** document for complete step-by-step instructions including:

1. **Conceptual Foundation** - K8s architecture and HPA concepts
2. **Environment Setup** - Minikube and kubectl installation
3. **Deployment** - Deploy this application to K8s
4. **Scaling** - Manual and automatic scaling demonstrations
5. **Self-Healing** - See K8s automatically replace failed Pods
6. **Troubleshooting** - Solutions for common issues

## Files in This Directory

```
.
├── main.pdf               # Complete lab manual (start here!)
├── main.tex               # LaTeX source of lab manual
├── app.js                 # Node.js Express application
├── package.json           # Node.js dependencies
├── Dockerfile             # Container image configuration
├── .dockerignore          # Docker build exclusions
├── .gitignore             # Git exclusions
└── README.md              # This file
```

## What You'll Learn

By completing this lab, you'll understand:

- ✅ Kubernetes architecture (Control Plane, Worker Nodes, Pods)
- ✅ Declarative deployment with YAML files
- ✅ Services and networking in Kubernetes
- ✅ Manual scaling of applications
- ✅ Kubernetes self-healing capabilities
- ✅ Horizontal Pod Autoscaling (HPA)
- ✅ How Kubernetes compares to AWS and Azure scaling solutions

## Troubleshooting

### Docker image not found when deploying?

Make sure you ran:
```bash
eval $(minikube docker-env)
```

This connects your shell to Minikube's Docker daemon.

### Pod stuck in `CrashLoopBackOff`?

Check the logs:
```bash
kubectl logs <pod-name>
```

### Service URL returns "connection refused"?

Wait a few seconds for the Pod to initialize, then try again.

## Clean Up

After the lab, clean up resources:

```bash
# Delete service
kubectl delete service microservice-service

# Delete deployment
kubectl delete deployment microservice-deployment

# Stop Minikube
minikube stop
```

## Next Steps

After completing this lab:
- Explore more complex Kubernetes deployments
- Learn about persistent volumes
- Study service meshes (Istio)
- Practice with ConfigMaps and Secrets

## References

- **Kubernetes Documentation:** https://kubernetes.io/docs/
- **Minikube Documentation:** https://minikube.sigs.k8s.io/docs/
- **kubectl Cheat Sheet:** https://kubernetes.io/docs/reference/kubectl/cheatsheet/

---

**Happy Kubernetes Learning!** 🚀
