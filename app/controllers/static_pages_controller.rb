class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:contact, :about]
  def contact
    @contact = StaticPage.find_by(title: 'Contact')
  end

  def about
    @about = StaticPage.find_by(title: 'About')
  end
end
