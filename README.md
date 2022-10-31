# Desktop in Docker - Audio and Firefox

Desktop in Docker - Audio and Firefox image provide a Linux Xfce4 desktop environment by utilizing novnc plus PulseAudio and Firefox browser. Checkout the image Dockerfile as reference on how to use the did-base image to build more interesting Desktop in Docker images.

## Usage

Basic command:

```docker
docker run --rm -it -p 6901:6901 kalmufti/did-audio
```

Add container name, change host ip address and increase ram:

```docker
docker run --rm -it -p 6901:6901 --name novnc -e HOST_ADDR=192.168.1.1 --shm-size=2gb kalmufti/did-audio
```
