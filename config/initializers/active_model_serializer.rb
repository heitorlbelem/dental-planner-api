# frozen_string_literal: true

ActiveModelSerializers.config.adapter = ActiveModelSerializers::Adapter::JsonApi
ActiveModelSerializers.config.key_transform = :underscore
Mime::Type.register 'application/vnd.api+json', :json
