require 'watir'
require 'watir-scroll'
require 'rubygems'
require 'fileutils'
require 'rbconfig'
require 'headless'
require 'rspec'
require 'rest-client'
require 'rexml/document'
include REXML
#require 'mysql2'
#require 'pg'
require 'yaml'
require_relative './browser_helper'
require_relative './misc_helper'
require_relative './page_locator_helper'

## to read ENV variables ; can also be set/read from jenkins
require_relative '../config/env_cfg'





