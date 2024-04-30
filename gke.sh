
gcloud container clusters get-credentials vernal-isotope-420717-gke --zone us-east1-b

# configure kubectl 
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --zone $(terraform output -raw zone)


# Deploy Kubernetes Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Get login token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')

# Install Jenkins chart
helm install my-release oci://registry-1.docker.io/bitnamicharts/jenkins
