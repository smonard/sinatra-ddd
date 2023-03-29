# frozen_string_literal: true

root = File.expand_path(File.join(__dir__, '../..'))
$LOAD_PATH.unshift File.join(root, 'server')

require 'infrastructure/database/model/person'
