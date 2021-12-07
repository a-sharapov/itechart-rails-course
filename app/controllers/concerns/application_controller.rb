# frozen_string_literal: true

class ApplicationController < ActionController::Base
  
  protected
  def after_sign_in_path_for(resource)
    cabinet_path
  end
end
