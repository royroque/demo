require 'rubygems'
require 'rspec'
include RSpec::Matchers
require 'fileutils'
require 'rbconfig'
require 'yaml'

require 'watir'
require 'watir-scroll'
require 'headless'
require 'rest-client'
require 'rexml/document'
include REXML
#require 'mysql2'
#require 'pg'

require_relative './browser_helper'
require_relative './misc_helper'
require_relative './page_locator_helper'

## to read ENV variables ; can also be set/read from jenkins
require_relative '../config/env_cfg'





