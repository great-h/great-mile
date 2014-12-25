require 'rails_helper'

feature "Root", :type => :feature do
  it "visit /" do
    visit "/"
  end
end
