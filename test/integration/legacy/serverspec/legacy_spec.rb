# Workaround for load spec_helper on Travis
libdir = File.expand_path(File.join(File.dirname(__FILE__), '../../helpers/serverspec'))
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir) || $LOAD_PATH.include?(libdir)
#

require 'spec_helper'

describe 'Android SDK' do
  include_examples 'basic suite'
end
