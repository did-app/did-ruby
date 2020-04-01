# [DID.app](https://did.app) Ruby

[DID.app](https://did.app) is an Identity Provider, that authenticates users by verifying access to either an email address or securely stored private key.

## Examples

This repo contains Ruby applications that use [DID.app](https://did.app) authentication.

- [Rails](examples/rails)

## Where's the library?

There is no specific library, integration involves a single HTTP request and is well documented in our guides.
This repo contains examples referenced in [our guides](https://did.app/docs).

For passwordless authentication in your app follow our [Ruby on Rails integration guide](https://did.app/guides/ruby-on-rails-openid-connect-integration/)

## Contributing

Contributions are very welcome. Please do open an issue or pull request or reach out to us at [team@trykno.com](mailto:team@trykno.com)

#### Docker

If you do not have Ruby installed, you can run a Ruby sandbox in Docker with the following command.

```bash
docker-compose run app bash
```
