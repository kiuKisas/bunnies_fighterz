# frozen_string_literal: true

module StatConcern
  extend ActiveSupport::Concern

  included do

    def to_map
      attributes.symbolize_keys.delete_if do |key|
        %i[updated_at created_at id bunny_id weapon_id].include?(key)
      end
    end
  end

end
