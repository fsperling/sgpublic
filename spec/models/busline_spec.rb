require 'rails_helper'

RSpec.describe Busline do
  #it "should respond to attributes" do
    #busline = Busline.new
      #expect(busline).to have_attribute(:busnumber)
  #end

  it { should respond_to(:busnumber) }
  it { should respond_to(:start_code) }
  it { should respond_to(:end_code) }
  it { should respond_to(:busstops) }
end
