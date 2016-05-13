class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



def file_permit(param)
    [param.to_sym, "#{param}_uid".to_sym, "#{param}_name".to_sym, "remove_#{param}".to_sym, "retained_#{param}".to_sym]
end



alias_method :fp, :file_permit

end
