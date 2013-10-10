class DrunkwalkController < ApplicationController

	def index
	end

	def walk
	  @steps = params[:steps]
	  simulator = DrunkSimulator.new(@steps)
	  @final_distance = simulator.final_distance
	  @estimated_distance = simulator.estimated_distance
	  @points = simulator.points
	  @distance = simulator.distance
	  @distance_n = simulator.distance_n
	end
end

class DrunkSimulator

	STEP_SIZE = 1

	def initialize(steps)
		@steps = steps.to_i
		compute()
	end

	def points
		@points
	end

	def distance
		@d
	end

	def distance_n
		@r_n
	end

	def final_distance
		@final_distance
	end

	def estimated_distance
		@estimated_distance
	end

	private

	def compute
        angle = 0
        seed = Random.new_seed
        @points = [[0,0]]
        @d = [[0,0]]
        @r_n = [[0,0]]

        for i in 0...@steps do
            angle = 1 - Random.rand
            angle = angle * 360
            angle = angle * Math::PI/180
            
            @points[i+1] = [@points[i][0] + (STEP_SIZE * Math.cos(angle)),
                           @points[i][1] + (STEP_SIZE * Math.sin(angle))]

            @d[i+1] = [i+1, Math.sqrt((points[i+1][0] ** 2) + (points[i+1][1] ** 2))]

            @r_n[i] = [i, Math.sqrt(i)]
        end

        @final_distance = @d[@steps][1];
        @estimated_distance = Math.sqrt(@steps);
	end
end