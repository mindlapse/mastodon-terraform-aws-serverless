# mastodon_static

This module is:

- A cloudfront distribution
- An S3 bucket (with static files, like CSS and JS, from the mastodon build)

- The distribution points the following paths to an S3 bucket:
  - /sw.js
  - /assets/
  - /avatars/
  - /emoji/
  - /headers/
  - /packs/
  - /shortcuts/
  - /sounds/
  - /system/

- The following headers are added to the above paths
  -  Cache-Control "public, max-age=2419200, must-revalidate"
  -  Strict-Transport-Security "max-age=63072000; includeSubDomains"
  
  