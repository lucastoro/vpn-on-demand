# A basic SSH-based SOCKS5 proxy to use on-demand

## How it works

- Build the OCI container containing SSHD via build.sh.
- Publish the container to hub.docker.com, AWS/ECR or whatever.
- Launch a cloud instance in the region you want to appear (AWS/EC2, GCP/Compute or whatever).
- In the cloud instance make sure you have access to docker/podman/whatever and TCP:2222 open toward your client.
- Run the OCI container inside the cloud instance.
- Connect to the instance through `bash run_client.sh [instance hostname]`.
- Configure you OS/Browser to use localhost:8888 as SOCKS5 proxy server.
- Profit
- Terminate the remote instance