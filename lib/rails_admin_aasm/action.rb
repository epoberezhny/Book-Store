module RailsAdmin
  module Config
    module Actions
      class State < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :controller do
          Proc.new do |klass|
            unless @authorization_adapter.nil? || @authorization_adapter.authorized?(:all_events, @abstract_model, @object)
              @authorization_adapter.try(:authorize, params[:event].to_sym, @abstract_model, @object)
            end

            @state_machine_options = ::RailsAdminAasm::Configuration.new @abstract_model
            if params['id'].present?
              begin
                raise 'event disabled' if @state_machine_options.disabled?(params[:event].to_sym)
                # if @object.send("fire_#{params[:attr]}_event".to_sym, params[:event].to_sym)
                if @object.send("may_#{params[:event]}?".to_sym)
                  @object.send("#{params[:event]}!")
                  flash[:success] = I18n.t('admin.state_machine.event_fired', attr: params[:method], event: params[:event])
                else
                  flash[:error] = obj.errors.full_messages.join(', ')
                end
              rescue Exception => e
                Rails.logger.error e
                flash[:error] = I18n.t('admin.state_machine.error', err: e.to_s)
              end
            else
              flash[:error] = I18n.t('admin.state_machine.no_id')
            end
            redirect_back(fallback_location: dashboard_path)
          end
        end
      end
    end
  end
end
