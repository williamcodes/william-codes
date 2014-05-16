class EtsyController < ApplicationController

  def for_etsy
    @actor = Actor.find_by(name: bacon_params[:name])
    @actor = Actor.find_by(name: "Kevin Bacon") if @actor.nil?
    @bacon_finder = BaconFinder.new(@actor)
  end

  def find_bacon
    @actor = Actor.find_by(name: bacon_params[:name])
    @bacon_finder = BaconFinder.new(@actor)
    @bacon_finder.find_bacon
    @path = @bacon_finder.short_path
  end

  private
    def bacon_params
      params.permit(:name)
    end
end
