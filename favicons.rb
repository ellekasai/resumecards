#!/usr/bin/env ruby

require 'fileutils'
require 'json'
require 'pathname'
require 'uri'

require 'down'
require 'rest-client'

verbose = true

dest_dir_path = Pathname.new('./_assets/favicons')
unless dest_dir_path.directory?
  abort("ERROR: #{dest_dir_path} is not a directory. Aborting...")
end

env_vars_found = true
env_vars = %w[FAVICON_TOKEN ORIGINAL_IMG_URL]
env_vars.each do |env_var|
  if ENV[env_var] == ''
    env_vars_found = false
    STDERR.puts "ERROR: #{env_var} found as an empty environment variable."
  elsif !ENV[env_var]
    env_vars_found = false
    STDERR.puts "ERROR: #{env_var} not found as an environment variable."
  end
end
unless env_vars_found
  abort('ERROR: At least one env var not usable. Aborting...')
end

url = 'https://realfavicongenerator.net/api/favicon'
# Payload based on default realfavicongenerator's interactive API settings.
payload =
  { 'favicon_generation' =>
    { 'api_key' => ENV['FAVICON_TOKEN'],
      'master_picture' =>
        { 'type' => 'url',
          'url' => ENV['ORIGINAL_IMG_URL'] },
      'files_location' =>
        { 'type' => 'root' },
      'favicon_design' =>
        { 'desktop_browser' => {},
          'ios' =>
            { 'picture_aspect' => 'no_change',
              'assets' =>
                { 'declare_only_default_icon' => 'true' } },
          'windows' =>
            { 'picture_aspect' => 'no_change',
              'assets' =>
                { 'windows_10_ie_11_edge_tiles > medium' => 'true' } },
          'android_chrome' =>
            { 'picture_aspect' => 'no_change',
              'manifest' =>
                { 'display' => 'standalone' } },
          'safari_pinned_tabs' =>
            { 'picture_aspect' => 'no_change' } },
      'settings' =>
        { 'compression' => '0',
          'scaling_algorithm' => 'Mitchell' } } }.to_json
headers = { content_type: :json }
response = RestClient.post(url, payload, headers)
data = JSON.parse(response)
if data['favicon_generation_result']['result']['status'] == 'success'
  verbose && puts('Successful favicon generation!')
  files_urls = data['favicon_generation_result']['favicon']['files_urls']
  files_urls.each do |current_url|
    uri = URI.parse(current_url)
    file_name = File.basename(uri.path)
    tempfile = Down.download(current_url)
    dest_file = File.join(dest_dir_path, file_name)
    FileUtils.mv(tempfile, dest_file)
    verbose && puts("Moved #{tempfile.path} to #{dest_file}")
  end
  verbose && puts('Favicon procedure done!')
else
  abort('Something went wrong. Check manually. Aborting...')
end
