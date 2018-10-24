This Docker image is based on the [yamamuteki/debian-etch-i386](https://github.com/yamamuteki/debian-etch-i386) Debian Etch docker image.

The main purpose of this docker image is to create a vulnerable environment to exploit [CRIME](https://en.wikipedia.org/wiki/CRIME). To run this image after installing Docker, use a command like this:

```bash
$ sudo docker run --rm -p 443:443 jselvi/docker-crime
```

Now you can test if we are facing a vulnerable web server by using a tool such as testssl.sh:

```bash
$ testssl.sh --crime https://127.0.0.1

 Testing for CRIME vulnerability

  1 Listen 443
 CRIME, TLS (CVE-2012-4929)                VULNERABLE (NOT ok)
```

The legitimate user should visit `https://127.0.0.1/setcookie.html`. This page will create a new cookie for the user. Now if you visits `https://127.0.0.1` you will find a message "ACCESS GRANTED".

An attacker should be able to exploit CRIME and obtain the cookie value. For this example, this cookie is static and never changes. It doesn't really matter to exploit the issue, and it was much easier to implement.