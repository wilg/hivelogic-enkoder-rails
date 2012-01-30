# encoding: utf-8
require 'spec_helper'

describe EnkoderRails::HelperAdditions do
  
  before(:each) do
    @enkoder = Class.new.extend(EnkoderRails::HelperAdditions)
  end
  
  it "enkode doesn't include the encoded string" do
    # This is an awful test and should probably be replaced.
    
    str = "5by5"
    @enkoder.enkode(str).should_not include(str)
  end
  
  it "enkode_mail doesn't include the email address" do
    # This is an awful test and should probably be replaced.
    
    email = "test@example.com"
    @enkoder.enkode_mail(email, "test").should_not include(email)
  end

end
