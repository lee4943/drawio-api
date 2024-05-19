# drawio-api

- Convert `.vsdx` files to `.svg` using Draw.io/Flask
- Largely inspired by https://github.com/rlespinasse/docker-drawio-desktop-headless
- Simple POC of exposing Draw.io's command line functionality via an API

### How to use

- `./build.sh`
  - Build docker image, create staging directory for received files (to be mounted into container, for file visibility purposes), run docker container (with volume mount & port 8000 published)
- `./post.sh`
  - Use `curl` to `POST` a local `example.vsdx` (to be provided by the user) to our lone endpoint, `/convert-vsdx`
  - Redirect response to a file, `converted_file.svg`
