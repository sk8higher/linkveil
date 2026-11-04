# Linkveil

Linkveil is a lightweight Ruby gem that removes tracking parameters from shared URLs while preserving unrelated query parameters.

## Features

- Remove platform-specific tracking parameters.
- Preserve unrelated query parameters and their original encoding.
- Support YouTube, Spotify, and TikTok.
- Keep unknown domains unchanged.
- Use Linkveil as a Ruby library or command-line tool.
- Extend supported platforms with a simple sanitizer DSL.

## Installation

Add Linkveil to your Gemfile:

```ruby
gem 'linkveil'
```

Then run:

```sh
bundle install
```

Or install it directly:

```sh
gem install linkveil
```

## Usage

### Ruby API

```ruby
require 'linkveil'

Linkveil.clean('https://youtu.be/abc?si=secret&t=120')
# => "https://youtu.be/abc?t=120"

Linkveil.clean('https://open.spotify.com/track/abc123?si=secret')
# => "https://open.spotify.com/track/abc123"

Linkveil.clean('https://example.com/?foo=bar')
# => "https://example.com/?foo=bar"
```

### Command-line interface

```sh
linkveil 'https://youtu.be/abc?si=secret&t=120'
```

Output:

```text
https://youtu.be/abc?t=120
```

If no URL is provided, Linkveil prints usage instructions to stderr and exits with a non-zero status.

**Windows note:** Depending on your shell and the RubyGems-generated `.bat` launcher, URLs containing `&` may require special handling. When developing from source, you can run:

```powershell
ruby exe/linkveil 'https://youtu.be/abc?si=secret&t=120'
```

## Supported platforms

| Platform | Domains                     | Removed parameters                |
| -------- | --------------------------- | --------------------------------- |
| YouTube  | `youtube.com`, `youtu.be`   | `si`, `feature`                   |
| Spotify  | `open.spotify.com`          | `si`                              |
| TikTok   | `tiktok.com` and subdomains | `is_from_webapp`, `sender_device` |

Linkveil only removes explicitly configured parameters. All other query parameters are preserved.

## Adding a sanitizer

Linkveil uses a small DSL to define platform-specific sanitizers.

```ruby
module Linkveil
  module Sanitizers
    class Example < Linkveil::Sanitizer
      domains 'example.com'
      remove_params 'tracking_id', 'ref'
    end
  end
end
```

Each sanitizer declares the domains it supports and the query parameters it removes.

## Development

Clone the repository:

```sh
git clone https://github.com/sk8higher/linkveil.git
cd linkveil
bundle install
```

Run the test suite:

```sh
bundle exec rspec
```

Build the gem locally:

```sh
gem build linkveil.gemspec
```

## Contributing

Bug reports, suggestions, and pull requests are welcome.

When adding support for a new platform, please include tests demonstrating that tracking parameters are removed and unrelated parameters are preserved.

## License

Linkveil is available under the [MIT License](LICENSE.txt).
