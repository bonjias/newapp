require "oauth"

QBO_KEY = 'qyprdxEr5BCP2eBMvYD8v5BQH4IJUQ'
QBO_SECRET = 'ZsedGmR8smTJNkMAaOw7odLZFeXlE1SP9MQWHw6Z'

$qb_oauth_consumer = OAuth::Consumer.new(QBO_KEY, QBO_SECRET, {
    :site                 => "https://oauth.intuit.com",
    :request_token_path   => "/oauth/v1/get_request_token",
    :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
    :access_token_path    => "/oauth/v1/get_access_token"
})