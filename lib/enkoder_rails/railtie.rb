module EnkoderRails
  class Railtie < Rails::Railtie
    
    initializer 'hivelogic_enkoder_rails.helper_additions' do
      ActionView::Base.send :include, HelperAdditions
    end
    
  end
end