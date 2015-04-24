require 'rubygems'
require 'google/api_client'
require 'launchy'
require 'daemons'

# # Get your credentials from the console
CLIENT_ID = '579663518499-oiuop4q0jsdcc4tbpvccfolhpl7a7mdu.apps.googleusercontent.com'
CLIENT_SECRET = 'rGWK21M02vV1etYPDfv8h4cV'
OAUTH_SCOPE = 'https://www.googleapis.com/auth/drive'
REDIRECT_URI = 'urn:ietf:wg:oauth:2.0:oob'
FILE_NAME ='refresh_token_database'
FILE_DIR = '/var/lib/transmission-daemon/downloads/'
token_arrays = nil	#it is for personal use only

class Refreshtoken 
	@@token = nil
	@@client=nil
	def initialize
		@@client = Google::APIClient.new
	end
	def retrieve
		@@client
	end

	def first_time_google_sdk_init
	# Create a new API client & load the Google Drive API
	drive = @@client.discovered_api('drive', 'v2')
	# Request authorization
	@@client.authorization.client_id = CLIENT_ID
	@@client.authorization.client_secret = CLIENT_SECRET
	@@client.authorization.scope = OAUTH_SCOPE
	@@client.authorization.redirect_uri = REDIRECT_URI
end


def exchange_refresh_token  token_param
	@@client.authorization.refresh_token = token_param
	a = @@client.authorization.fetch_access_token!
	puts a
end


def get_refresh_token
	# Exchange authorization code for access token
	uri = @@client.authorization.authorization_uri
	Launchy.open(uri)
	$stdout.write  "Enter authorization code: "
 	@@client.authorization.code = gets.chomp
	@@client.authorization.fetch_access_token!
	@@client.authorization.refresh_token
	store_token
end
	def store_token
		file  = File.open(FILE_NAME, 'a')
		file.puts(@@client.authorization.refresh_token.to_s)
		file.close
	end

end

class Fileop
	def file_check
		if !(File.exists? FILE_NAME)
			file = File.new(FILE_NAME,'w')
			file.close
		end
	end
	def get_file
		File.open(FILE_NAME, 'r').read
	end

end



#check file existing, make sure file to be there
op = Fileop.new
op.file_check
file = op.get_file

if file.nil?
	token_arrays = nil
else
	token_arrays = file.split("\n")
end

refresh = Refreshtoken.new
refresh.first_time_google_sdk_init

if token_arrays.nil? 
	refresh.get_refresh_token
elsif token_arrays[0].nil?
	refresh.get_refresh_token
else
	refresh.exchange_refresh_token token_arrays[0].to_s
end


Daemons.run('uploading.rb')






















# Insert a file
# file = drive.files.insert.request_schema.new({
# 	'title' => 'My document',
# 	'description' => 'A test document',
# 	'mimeType' => 'text/plain'
# })

# media = Google::APIClient::UploadIO.new('document.txt', 'text/plain')
# result = client.execute(
# 	:api_method => drive.files.insert,
# 	:body_object => file,
# 	:media => media,
# 	:parameters => {
# 	'uploadType' => 'multipart',
# 	'alt' => 'json'})
