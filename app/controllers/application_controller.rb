class ApplicationController < ActionController::Base
  
  def after_sign_in_path_for(resource)
    if resource == :admin
      # 管理者側の遷移先
      admin_homes_top_path
    elsif rosource == :user
      # 顧客側の遷移先
      root_path
    end
  end
end
