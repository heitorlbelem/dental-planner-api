# frozen_string_literal: true

module ErrorSerializer
  def self.serialize(record, status)
    return if record.errors.nil?

    json = {}
    json[:errors] = record.errors.to_hash(true).map do |k, v|
      v.map do |msg|
        {
          id: SecureRandom.uuid,
          detail: msg,
          status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status],
          source: {
            pointer: "/data/attributes/#{k}"
          }
        }
      end
    end.flatten
    json
  end
end
