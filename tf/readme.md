# Creating GKE cluster using terraform 

![Alt text](image.png)
## The components that will be created as follows:
1. A network named vpc.
2. A Subnetwork named subnet.
3. A private cluster named primary has private nodes and has no client access to the public endpoint.
4. Managed node pool with 2 sets of nodes.
5. A Linux Jump host named jump-host with internal IP only. No Public IP is attached. This machine will be accessible over the internal ipv4 address using IAP.
6. A Cloud Nat gateway named nat-config
7. IAP SSH permission

## Prequisites:
1. Create a project for the website on GCP.
2. Enable Compute Engine API: <br />
    ```bash
    gcloud services enable compute.googleapis.com
    ```
3. Enable Kubernetes Engine API:
    ```bash
    gcloud services enable container.googleapis.com
    ```
