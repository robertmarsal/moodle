# Moodle
[![Build Status](https://travis-ci.org/robertboloc/moodle.png)](https://travis-ci.org/robertboloc/moodle)
[![Code Climate](https://codeclimate.com/github/robertboloc/moodle.png)](https://codeclimate.com/github/robertboloc/moodle)
[![Gem Version](https://badge.fury.io/rb/moodle.png)](http://badge.fury.io/rb/moodle)

Ruby gem to interact with Moodle via web services.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
- [Protocols](#protocols)
- [Functions](#functions)

## Installation
```shell
gem install moodle
```

## Usage
To use this gem you must first have configured the moodle web services. To do that use the official documentation.

### Without a token
If you don't have a token, you can create an instance of the client using your username and password.
The client will then obtain a token for you.
```ruby
client = Moodle::Client.new(
  :username => 'myusername',
  :password => 'secret',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)
```

### Using a token
If you already have a token the client can be created without a username and password:
```ruby
client = Moodle::Client.new(
  :token => 'b31dde13bade28f25d548a31fa994816',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)
```

### Short syntax
When creating the client you can use a shorter and simpler syntax:
```ruby
client = Moodle.new(
  :token => 'b31dde13bade28f25d548a31fa994816',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)
```

### Global configuration
Configuration can be set globally.
```ruby
# Using a hash
Moodle.configure(
  :token => 'b31dde13bade28f25d548a31fa994816',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)

# Using a file
Moodle.configure_with(/path/to/yaml/file)

client = Moodle.new
```

Once you have an instance of the client it's only a matter of calling the moodle web services functions.

## Protocols
Moodle implements 4 protocols: AMF, REST, SOAP, XML-RPC. Currently this gem only supports REST.

## Functions
These are the currently implemented web services functions:

### User

#### core_user_get_users_by_field
Retrieve users information for a specified unique field
```ruby
user = client.core_user_get_users_by_field('id', [2])

user.id                   # => 2,
user.firstname            # => Test
user.lastname             # => User
user.fullname             # => Test User
user.email                # => webservicetester@gmail.com
user.firstaccess          # => 139240932,
user.lastaccess           # => 1392471263
user.profileimageurlsmall # => http://mydomain/moodle/pluginfile.php/5/user/icon/f2
user.profileimageurl      # => http://mydomain/moodle/pluginfile.php/5/user/icon/f1
```

#### core_user_get_users
Search for users matching the criteria
```ruby
users = client.core_user_get_users({:email => 'suchemail@test.com'})

users.each do |user|
  user.id                   # => 2,
  user.firstname            # => Test
  user.lastname             # => User
  user.fullname             # => Test User
  user.email                # => suchemail@test.com
  user.firstaccess          # => 139240932,
  user.lastaccess           # => 1392471263
  user.profileimageurlsmall # => http://mydomain/moodle/pluginfile.php/5/user/icon/f2
  user.profileimageurl      # => http://mydomain/moodle/pluginfile.php/5/user/icon/f1
end
```

### Webservice

#### core_webservice_get_site_info
Return some site info / user info / list web service functions
```ruby
info = client.core_webservice_get_site_info

info.sitename       # => Webservice test
info.username       # => test
info.firstname      # => Test
info.lastname       # => Webservice
info.fullname       # => Test Webservice
info.lang           # => en
info.userid         # => 3
info.siteurl        # => http://mydomain/moodle
info.userpictureurl # => http://mydomain/moodle/pluginfile.php/15/user/icon/f1
info.functions.each do |f|
  f.name            # => core_user_get_users_by_field
  f.version         # => 2013111800.09
end
info.downloadfiles  # => 0
info.uploadfiles    # => 0
info.release        # => 2.6+ (Build: 20140110)
info.version        # => 2013111800.09
info.mobilecssurl   # => ""
```