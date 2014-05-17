class EtsyController < ApplicationController

  def for_etsy
  end

  def find_bacon
    actor = Actor.find_by(name: bacon_params[:name])
    actor ||= Actor.find_by(name: "Kevin Bacon")
    @bacon_finder = BaconFinder.new(actor)
    @bacon_finder.find_bacon
    @path = @bacon_finder.short_path
  end

  private
    def bacon_params
      params.permit(:name)
    end
end
