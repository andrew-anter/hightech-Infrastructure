# Jenkins slave Deployment

This is the deployment files to create a worker jenkins agent (slave agent) to run pipelines. <br />

### The Dockerfile creates an image that has the required tools as follows:
1. <b>docker</b> to push image to dockerhub after the build process.
2. <b>kubectl</b> to deploy the created docker image to GKE cluster.
3. <b>gcloud cli</b> to communicate with the GKE cluster through kubectl.
4. <b>gke-gcloud-auth-plugin</b> to authenticate with the GKE cluster.
4. <b>helm3</b>
5. <b>java11</b> which is the same as java in jenkins master deployment so that the master can communicate with the slave agent.
6. <b>envsubst</b> which is used in the pipeline.

