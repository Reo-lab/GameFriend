# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://gamefriend333.com/'

SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily', priority: 1.0
end
