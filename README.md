# DID Ruby

DID is an Identity Provider, that authenticates users by verifying access to either an email address or securely stored private key.

## Examples

This repo contains Ruby applications that use DID authentication.

- TODO

## Where's the library?

There is no specific DID library needed to integrate with [did.app](https://did.app)
The openid connect library is all that is required.

<!-- Instead follow our guide for [using did with express](https://did.app/guides/express-nodejs-openid-connect-integration). -->

## Contributing

Contributions are very welcome. Please do open an issue or pull request or reach out to us at [team@trykno.com](mailto:team@trykno.com)

#### Docker

If you do not have node installed, you can run locally in Docker with the following command.

```bash
docker run \
  -it \
  --rm \
  -w="/opt/app" \
  -v="$(pwd):/opt/app" \
  --env="PORT=3000" \
  --network="host" \
  ruby:2.7.0 bash
```

**NOTE**: You will need to bundle install every time you start a container with this command
