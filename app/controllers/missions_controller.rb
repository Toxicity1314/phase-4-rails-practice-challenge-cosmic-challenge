class MissionsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    def create
        mission = Mission.create!(mission_params)
        planet = Planet.find(mission.planet_id)
        render json: planet, status: :created, serializer: PlanetSerializer
    end

    private

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
