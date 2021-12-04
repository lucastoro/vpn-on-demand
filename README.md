# A simple SSH-based SOCKS proxy to use on-demand

## Disclaimer

This is a PoC, use it at your own risk and make sure you know what you're doing.

## How it works

VPNs are becoming more and more easily available but have few problems:
- They are expensive: for sporadic use VPN subscriptions are quite expensive, one should pay only for the time the VPN is used.
- They are black-boxes: In general you don't really know how VPNs are managed and how logs are handled, an open-source project could help.
- They are overkill: Virtual Private Networks are complex entities, while Proxies are simple and lightweight in comparison, for most use cases a Proxy is what you want to be actually using.

The SSH Daemon (SSHd) historically can be used as a SOCKS proxy, from the [man pages](https://linux.die.net/man/1/ssh)
> -D [bind_address:]port   
Specifies a local ''dynamic'' application-level port forwarding. This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address. Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the remote machine. Currently the SOCKS4 and SOCKS5 protocols are supported, and ssh will act as a SOCKS server. Only root can forward privileged ports. Dynamic port forwardings can also be specified in the configuration file.

A SOCKS proxy can be used as a simple replacement for a VPN when anonimity is not required and IP Masking is enough.

## How to use it

- Build the OCI container containing SSHd via build.sh.
- Publish the container to hub.docker.com, AWS/ECR or whatever.
- Launch a cloud instance in the region you want to appear (AWS/EC2, GCP/Compute or whatever).
- In the cloud instance make sure you have access to docker/podman/whatever and TCP:2222 open toward your client.
- Run the OCI container inside the cloud instance.
- Connect to the instance through `bash run_client.sh [instance hostname]`.
- Configure you OS/Browser to use localhost:8888 as SOCKS5 proxy server.
- Profit
- Terminate the remote instance

## Caveat / Notes

### SSH Auth

SSH authentication is achieved through a public key pair so:
- make sure to have id_rsa.pub in ./docker when building the container
- when connecting to the host via run_client.sh make sure to have the private key.

A better option is probably to provide the public key to the instance during the startup process instead of embedding it into the container.

### AWS/EC2 + Docker

On the Amazon Linux 2 AMI a working docker runner can be obtained via
```
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

sudo yum update -y
sudo amazon-linux-extras install docker
sudo yum install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
```

## TODO
Automate the whole process via a script/executable to
1. Generate the SSH key pair.
1. Launch the cloud instance on the region of choice.
1. Upload the public key to the instance.
1. Start the sshd container passing the pub key.
1. [wait for user interaction]
1. terminate the cloud instance